import { createServerSupabaseClient } from '@/lib/supabase/server'
import { getMasterSite } from '@/lib/queries/sites.server'

export interface DistributionItem {
  purchase_request_id: string
  purchase_request_item_id: string
  product_id: string
  product_name: string
  product_unit: string
  quantity_received: number
  quantity_distributed: number
  quantity_available: number
  unit_price: number | null
  site_id: string | null // Original site from purchase request (if any)
  site_name: string | null
  target_site_id: string | null // Target site where item should be distributed
  target_site_name: string | null
}

/**
 * Get items in master warehouse that came from fulfilled purchase requests
 * and are ready to be distributed to sites
 */
export async function getDistributionItems(): Promise<DistributionItem[]> {
  const supabase = await createServerSupabaseClient()
  
  // Get master site
  const masterSite = await getMasterSite()
  if (!masterSite) {
    return []
  }

  // Get all fulfilled/partially_fulfilled purchase requests
  const { data: requests, error: requestsError } = await supabase
    .from('purchase_requests')
    .select(`
      id,
      site_id,
      site:sites(id, name)
    `)
    .in('status', ['fulfilled', 'partially_fulfilled'])
    .is('deleted_at', null)
  
  if (requestsError) throw requestsError
  if (!requests || requests.length === 0) return []

  const requestIds = requests.map((r: { id: string }) => r.id)

  // Get purchase request items that have been received
  const { data: items, error: itemsError } = await supabase
    .from('purchase_request_items')
    .select(`
      id,
      purchase_request_id,
      product_id,
      quantity_requested,
      quantity_received,
      unit_price,
      target_site_id,
      product:products(id, name, unit),
      target_site:sites(id, name)
    `)
    .in('purchase_request_id', requestIds)
    .gt('quantity_received', 0)
  
  if (itemsError) throw itemsError
  if (!items || items.length === 0) return []

  // Get current stock in master for these products
  const productIds = [...new Set(items.map((i: { product_id: string }) => i.product_id))]
  const { data: masterInventory, error: inventoryError } = await supabase
    .from('site_inventory')
    .select('product_id, quantity_on_hand')
    .eq('site_id', masterSite.id)
    .in('product_id', productIds)
  
  if (inventoryError) throw inventoryError
  
  const masterStockMap = new Map(
    (masterInventory || []).map((inv: { product_id: string; quantity_on_hand: number }) => [inv.product_id, inv.quantity_on_hand])
  )

  // Get stock movements to calculate how much was already distributed
  // We'll track transfers FROM master TO other sites for these products
  const { data: transfers, error: transfersError } = await supabase
    .from('stock_movements')
    .select('product_id, quantity, notes')
    .eq('site_id', masterSite.id)
    .eq('movement_type', 'OUT')
    .in('product_id', productIds)
    .like('notes', '%Purchase from request%')
  
  if (transfersError) throw transfersError

  // Calculate distributed quantities per product
  const distributedMap = new Map<string, number>()
  transfers?.forEach((transfer: { product_id: string; quantity: number }) => {
    const current = distributedMap.get(transfer.product_id) || 0
    distributedMap.set(transfer.product_id, current + transfer.quantity)
  })

  // Build distribution items
  const distributionItems: DistributionItem[] = []
  
  for (const item of items) {
    const itemData = item as any
    const request = requests.find((r: { id: string }) => r.id === itemData.purchase_request_id)
    if (!request) continue

    const masterStock = masterStockMap.get(itemData.product_id) || 0
    const distributed = distributedMap.get(itemData.product_id) || 0
    const quantityReceived = itemData.quantity_received || 0
    
    // Available = what's in master that came from this purchase
    // We'll use a simple heuristic: if master stock >= quantity_received, assume it's available
    // In a more sophisticated system, we'd track which items came from which purchase
    const quantityAvailable = Math.min(masterStock, quantityReceived - distributed)

    if (quantityAvailable > 0) {
      const requestData = request as any
      distributionItems.push({
        purchase_request_id: itemData.purchase_request_id,
        purchase_request_item_id: itemData.id,
        product_id: itemData.product_id,
        product_name: itemData.product.name,
        product_unit: itemData.product.unit,
        quantity_received: quantityReceived,
        quantity_distributed: distributed,
        quantity_available: quantityAvailable,
        unit_price: itemData.unit_price || null,
        site_id: requestData.site_id === masterSite.id ? null : requestData.site_id,
        site_name: requestData.site?.id === masterSite.id ? null : requestData.site?.name || null,
        target_site_id: itemData.target_site_id || null,
        target_site_name: itemData.target_site?.name || null,
      })
    }
  }

  return distributionItems
}

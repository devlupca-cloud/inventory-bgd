import { createServerSupabaseClient } from '@/lib/supabase/server'

export interface DistributionTracking {
  item_id: string
  product_id: string
  product_name: string
  product_unit: string
  target_site_id: string | null
  target_site_name: string | null
  quantity_requested: number
  value_requested: number
  quantity_distributed: number
  value_distributed: number
  unit_price: number
}

/**
 * Get distribution tracking for a purchase request
 * Shows what was requested vs what was actually distributed to each site
 */
export async function getDistributionTracking(requestId: string): Promise<DistributionTracking[]> {
  const supabase = await createServerSupabaseClient()
  
  // Get all items from the purchase request
  const { data: items, error: itemsError } = await supabase
    .from('purchase_request_items')
    .select(`
      id,
      product_id,
      quantity_requested,
      quantity_received,
      unit_price,
      target_site_id,
      product:products(id, name, unit),
      target_site:sites(id, name)
    `)
    .eq('purchase_request_id', requestId)
  
  if (itemsError) throw itemsError
  if (!items || items.length === 0) return []

  // Get all distributions (stock movements) related to these items
  // We'll look for TRANSFER_IN movements to target sites
  const tracking: DistributionTracking[] = []

  for (const item of items) {
    const itemData = item as any
    const unitPrice = itemData.unit_price || itemData.product.price || 0
    const valueRequested = itemData.quantity_requested * unitPrice

    // Get distributions for this specific product to the target site
    let quantityDistributed = 0
    
    if (itemData.target_site_id) {
      const { data: movements } = await supabase
        .from('stock_movements')
        .select('quantity')
        .eq('movement_type', 'TRANSFER_IN')
        .eq('site_id', itemData.target_site_id)
        .eq('product_id', itemData.product_id)
        .or(`notes.ilike.%${requestId}%,notes.ilike.%Purchase from request%,notes.ilike.%Distribution from purchase request%`)
      
      if (movements && movements.length > 0) {
        quantityDistributed = movements.reduce((sum: number, m: any) => sum + m.quantity, 0)
      }
    }

    const valueDistributed = quantityDistributed * unitPrice

    tracking.push({
      item_id: itemData.id,
      product_id: itemData.product_id,
      product_name: itemData.product.name,
      product_unit: itemData.product.unit,
      target_site_id: itemData.target_site_id || null,
      target_site_name: itemData.target_site?.name || null,
      quantity_requested: itemData.quantity_requested,
      value_requested: valueRequested,
      quantity_distributed: quantityDistributed,
      value_distributed: valueDistributed,
      unit_price: unitPrice,
    })
  }

  return tracking
}

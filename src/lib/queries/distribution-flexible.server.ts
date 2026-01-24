import { createServerSupabaseClient } from '@/lib/supabase/server'
import { getMasterSite } from '@/lib/queries/sites.server'

export interface FlexibleDistributionItem {
  product_id: string
  product_name: string
  product_unit: string
  master_stock: number // Total available in master warehouse
  from_request?: {
    purchase_request_id: string
    purchase_request_item_id: string
    quantity_received: number
    quantity_distributed: number
    quantity_available: number
    unit_price: number | null
    target_site_id: string | null
    target_site_name: string | null
  }
  // Additional stock from other sources (other requests, direct purchases)
  additional_stock: number
}

/**
 * Get all products available in master warehouse for distribution
 * This includes items from the specific purchase request AND any other stock in master
 */
export async function getFlexibleDistributionItems(
  purchaseRequestId?: string
): Promise<FlexibleDistributionItem[]> {
  const supabase = await createServerSupabaseClient()
  
  // Get master site
  const masterSite = await getMasterSite()
  if (!masterSite) {
    return []
  }

  // Get all products in master warehouse
  const { data: masterInventory, error: inventoryError } = await supabase
    .from('site_inventory')
    .select(`
      product_id,
      quantity_on_hand,
      product:products(id, name, unit)
    `)
    .eq('site_id', masterSite.id)
    .gt('quantity_on_hand', 0)
  
  if (inventoryError) throw inventoryError
  if (!masterInventory || masterInventory.length === 0) return []

  // If a specific purchase request is provided, get items from that request
  let requestItems: any[] = []
  if (purchaseRequestId) {
    const { data: request, error: requestError } = await supabase
      .from('purchase_requests')
      .select('id, status')
      .eq('id', purchaseRequestId)
      .is('deleted_at', null)
      .maybeSingle()
    
    if (!requestError && request && ['fulfilled', 'partially_fulfilled'].includes(request.status)) {
      const { data: items, error: itemsError } = await supabase
        .from('purchase_request_items')
        .select(`
          id,
          purchase_request_id,
          product_id,
          quantity_received,
          unit_price,
          target_site_id,
          target_site:sites(id, name)
        `)
        .eq('purchase_request_id', purchaseRequestId)
        .gt('quantity_received', 0)
      
      if (!itemsError) {
        requestItems = items || []
      }
    }
  }

  // Get distributed quantities for request items
  const requestItemIds = requestItems.map((i: any) => i.id)
  let distributedMap = new Map<string, number>()
  
  if (requestItemIds.length > 0) {
    const { data: transfers } = await supabase
      .from('stock_movements')
      .select('product_id, quantity, notes')
      .eq('site_id', masterSite.id)
      .eq('movement_type', 'OUT')
      .like('notes', `%purchase request ${purchaseRequestId?.substring(0, 8)}%`)
    
    transfers?.forEach((transfer: { product_id: string; quantity: number }) => {
      const current = distributedMap.get(transfer.product_id) || 0
      distributedMap.set(transfer.product_id, current + transfer.quantity)
    })
  }

  // Build flexible distribution items
  const distributionMap = new Map<string, FlexibleDistributionItem>()
  
  for (const inv of masterInventory) {
    const invData = inv as any
    const productId = invData.product_id
    const masterStock = invData.quantity_on_hand || 0
    
    // Find if this product is in the purchase request
    const requestItem = requestItems.find((i: any) => i.product_id === productId)
    
    if (requestItem) {
      const distributed = distributedMap.get(productId) || 0
      const quantityAvailable = Math.max(0, requestItem.quantity_received - distributed)
      const additionalStock = Math.max(0, masterStock - requestItem.quantity_received)
      
      distributionMap.set(productId, {
        product_id: productId,
        product_name: invData.product.name,
        product_unit: invData.product.unit,
        master_stock: masterStock,
        from_request: {
          purchase_request_id: requestItem.purchase_request_id,
          purchase_request_item_id: requestItem.id,
          quantity_received: requestItem.quantity_received,
          quantity_distributed: distributed,
          quantity_available: quantityAvailable,
          unit_price: requestItem.unit_price || null,
          target_site_id: requestItem.target_site_id || null,
          target_site_name: requestItem.target_site?.name || null,
        },
        additional_stock: additionalStock,
      })
    } else {
      // Product is in master but not from this request - can still be distributed
      distributionMap.set(productId, {
        product_id: productId,
        product_name: invData.product.name,
        product_unit: invData.product.unit,
        master_stock: masterStock,
        additional_stock: masterStock,
      })
    }
  }

  return Array.from(distributionMap.values())
}

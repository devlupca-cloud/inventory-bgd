import { createServerSupabaseClient } from '@/lib/supabase/server'
import { getMasterSite } from '@/lib/queries/sites.server'

export interface MonthlyPurchaseItem {
  product_id: string
  product_name: string
  product_unit: string
  total_requested: number // Total requested across all sites
  master_stock: number
  quantity_to_purchase: number // What actually needs to be purchased
  unit_price: number | null
}

export interface MonthlyPurchaseList {
  month: string
  year: number
  items: MonthlyPurchaseItem[]
  totalItems: number
  totalValue: number
}

/**
 * Get monthly purchase list for a specific month
 * Shows what was actually purchased (received) in the month - the spending history
 */
export async function getMonthlyPurchaseList(
  year: number,
  month: number
): Promise<MonthlyPurchaseList> {
  const supabase = await createServerSupabaseClient()
  
  // Get date range for the month
  const startDate = new Date(year, month - 1, 1)
  const endDate = new Date(year, month, 0, 23, 59, 59)
  
  // Get all purchase requests that were received (fulfilled or partially_fulfilled) in this month
  // We want to show what was actually purchased, so we look at when items were received
  // For now, we'll use the purchase request's updated_at when it was fulfilled
  // In the future, we could track when each item was received separately
  const { data: requests, error: requestsError } = await supabase
    .from('purchase_requests')
    .select(`
      id,
      site_id,
      site:sites(id, name)
    `)
    .in('status', ['fulfilled', 'partially_fulfilled'])
    .gte('updated_at', startDate.toISOString())
    .lte('updated_at', endDate.toISOString())
    .is('deleted_at', null)
  
  if (requestsError) throw requestsError
  if (!requests || requests.length === 0) {
    return {
      month: startDate.toLocaleString('default', { month: 'long' }),
      year,
      items: [],
      totalItems: 0,
      totalValue: 0,
    }
  }
  
  const requestIds = requests.map((r: { id: string }) => r.id)
  
  // Get all purchase request items that were actually received (quantity_received > 0)
  const { data: items, error: itemsError } = await supabase
    .from('purchase_request_items')
    .select(`
      purchase_request_id,
      product_id,
      quantity_requested,
      quantity_received,
      unit_price,
      product:products(id, name, unit, price)
    `)
    .in('purchase_request_id', requestIds)
    .gt('quantity_received', 0) // Only items that were actually received
  
  // Get direct purchases for this month
  const { data: directPurchases, error: directPurchasesError } = await supabase
    .from('direct_purchases')
    .select(`
      product_id,
      quantity_purchased,
      unit_price,
      product:products(id, name, unit, price)
    `)
    .gte('purchased_at', startDate.toISOString())
    .lte('purchased_at', endDate.toISOString())
    .is('deleted_at', null)
  
  if (directPurchasesError) throw directPurchasesError
  
  if (itemsError) throw itemsError
  if (!items || items.length === 0) {
    return {
      month: startDate.toLocaleString('default', { month: 'long' }),
      year,
      items: [],
      totalItems: 0,
      totalValue: 0,
    }
  }
  
  // Aggregate by product - show what was actually purchased (received)
  const aggregated = new Map<string, {
    product_id: string
    product_name: string
    product_unit: string
    total_purchased: number // Total quantity actually received/purchased
    unit_price: number | null
  }>()
  
  // Process purchase request items
  for (const item of items || []) {
    const itemData = item as any
    const quantityReceived = itemData.quantity_received || 0
    if (quantityReceived <= 0) continue // Skip if nothing was received
    
    // Aggregate by product only (not by product+site)
    const productKey = itemData.product_id
    
    const existing = aggregated.get(productKey)
    if (existing) {
      // Add received quantity to total purchased
      existing.total_purchased += quantityReceived
      // Use the highest unit_price if multiple (or average? for now using highest)
      if (itemData.unit_price && (!existing.unit_price || itemData.unit_price > existing.unit_price)) {
        existing.unit_price = itemData.unit_price
      }
    } else {
      aggregated.set(productKey, {
        product_id: itemData.product_id,
        product_name: itemData.product.name,
        product_unit: itemData.product.unit,
        total_purchased: quantityReceived,
        unit_price: itemData.unit_price || itemData.product.price || null,
      })
    }
  }
  
  // Process direct purchases
  for (const purchase of directPurchases || []) {
    const purchaseData = purchase as any
    const quantityPurchased = purchaseData.quantity_purchased || 0
    if (quantityPurchased <= 0) continue
    
    const productKey = purchaseData.product_id
    
    const existing = aggregated.get(productKey)
    if (existing) {
      // Add purchased quantity to total purchased
      existing.total_purchased += quantityPurchased
      // Use the highest unit_price if multiple
      if (purchaseData.unit_price && (!existing.unit_price || purchaseData.unit_price > existing.unit_price)) {
        existing.unit_price = purchaseData.unit_price
      }
    } else {
      aggregated.set(productKey, {
        product_id: purchaseData.product_id,
        product_name: purchaseData.product.name,
        product_unit: purchaseData.product.unit,
        total_purchased: quantityPurchased,
        unit_price: purchaseData.unit_price || purchaseData.product.price || null,
      })
    }
  }
  
  // Convert to purchase items format
  const purchaseItems: MonthlyPurchaseItem[] = Array.from(aggregated.values()).map(item => {
    return {
      product_id: item.product_id,
      product_name: item.product_name,
      product_unit: item.product_unit,
      total_requested: item.total_purchased, // For display, this is what was purchased
      master_stock: 0, // Not relevant for spending history
      quantity_to_purchase: item.total_purchased, // This is what was actually purchased
      unit_price: item.unit_price,
    }
  })
  
  // Sort by product name
  purchaseItems.sort((a, b) => a.product_name.localeCompare(b.product_name))
  
  // Calculate totals - based on what was actually purchased
  const totalItems = purchaseItems.reduce((sum, item) => sum + item.quantity_to_purchase, 0)
  const totalValue = purchaseItems.reduce(
    (sum, item) => sum + (item.quantity_to_purchase * (item.unit_price || 0)),
    0
  )
  
  return {
    month: startDate.toLocaleString('default', { month: 'long' }),
    year,
    items: purchaseItems,
    totalItems,
    totalValue,
  }
}

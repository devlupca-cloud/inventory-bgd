import { createServerSupabaseClient } from '@/lib/supabase/server'

export interface MonthlyPurchaseSummary {
  year: number
  month: number
  monthName: string
  totalValue: number
  totalItems: number
  requestCount: number
}

/**
 * Get monthly purchase summaries for all months with purchase requests
 * Returns data aggregated by month showing total values spent
 */
export async function getMonthlyPurchaseOverview(): Promise<MonthlyPurchaseSummary[]> {
  const supabase = await createServerSupabaseClient()
  
  // Get all purchase requests that have been at least submitted
  const { data: requests, error: requestsError } = await supabase
    .from('purchase_requests')
    .select('id, created_at')
    .in('status', ['submitted', 'approved', 'partially_fulfilled', 'fulfilled'])
    .is('deleted_at', null)
    .order('created_at', { ascending: false })
  
  if (requestsError) throw requestsError
  if (!requests || requests.length === 0) {
    return []
  }
  
  const requestIds = requests.map((r: { id: string }) => r.id)
  
  // Get all purchase request items with product prices
  // We'll calculate based on quantity_requested and unit_price to show estimated purchase values
  const { data: items, error: itemsError } = await supabase
    .from('purchase_request_items')
    .select(`
      purchase_request_id,
      quantity_requested,
      quantity_received,
      unit_price,
      product_id,
      product:products(id, price)
    `)
    .in('purchase_request_id', requestIds)
  
  // Get all direct purchases (grouped by month)
  const { data: directPurchases, error: directPurchasesError } = await supabase
    .from('direct_purchases')
    .select('product_id, quantity_purchased, unit_price, purchased_at, product:products(id, price)')
    .is('deleted_at', null)
  
  if (directPurchasesError) throw directPurchasesError
  
  if (itemsError) throw itemsError
  if (!items || items.length === 0) {
    return []
  }
  
  // Aggregate by month
  const monthlyData = new Map<string, {
    year: number
    month: number
    totalValue: number
    totalItems: number
    requestIds: Set<string>
  }>()
  
  // Create a map of request IDs to created_at dates
  const requestDateMap = new Map(
    requests.map((r: { id: string; created_at: string }) => [r.id, new Date(r.created_at)])
  )
  
  // Process purchase request items
  for (const item of items || []) {
    const itemData = item as any
    const requestDate = requestDateMap.get(itemData.purchase_request_id)
    if (!requestDate) continue
    
    const date = requestDate
    const year = date.getFullYear()
    const month = date.getMonth() + 1
    const key = `${year}-${month}`
    
    // Calculate remaining quantity to purchase
    const quantityRequested = itemData.quantity_requested || 0
    const quantityReceived = itemData.quantity_received || 0
    const remainingQuantity = quantityRequested - quantityReceived
    
    // Use unit_price from item, or fallback to product price if not set
    const product = itemData.product as any
    const productPrice = product?.price || 0
    const unitPrice = itemData.unit_price && itemData.unit_price > 0 ? itemData.unit_price : productPrice
    
    // If item was fully received, use received quantity and price for historical data
    // Otherwise, use remaining quantity for items still to be purchased
    const quantityToCount = remainingQuantity > 0 ? remainingQuantity : quantityReceived
    const itemValue = quantityToCount * unitPrice
    
    // Skip if no value (no price set at all) or no quantity
    if (itemValue <= 0 || quantityToCount <= 0) continue
    
    const existing = monthlyData.get(key)
    if (existing) {
      existing.totalValue += itemValue
      existing.totalItems += quantityToCount
      existing.requestIds.add(itemData.purchase_request_id)
    } else {
      monthlyData.set(key, {
        year,
        month,
        totalValue: itemValue,
        totalItems: quantityToCount,
        requestIds: new Set([itemData.purchase_request_id]),
      })
    }
  }
  
  // Process direct purchases
  for (const purchase of directPurchases || []) {
    const purchaseData = purchase as any
    const purchaseDate = new Date(purchaseData.purchased_at)
    const year = purchaseDate.getFullYear()
    const month = purchaseDate.getMonth() + 1
    const key = `${year}-${month}`
    
    const quantityPurchased = purchaseData.quantity_purchased || 0
    const product = purchaseData.product as any
    const productPrice = product?.price || 0
    const unitPrice = purchaseData.unit_price && purchaseData.unit_price > 0 ? purchaseData.unit_price : productPrice
    const purchaseValue = quantityPurchased * unitPrice
    
    if (purchaseValue <= 0 || quantityPurchased <= 0) continue
    
    const existing = monthlyData.get(key)
    if (existing) {
      existing.totalValue += purchaseValue
      existing.totalItems += quantityPurchased
    } else {
      monthlyData.set(key, {
        year,
        month,
        totalValue: purchaseValue,
        totalItems: quantityPurchased,
        requestIds: new Set(), // Direct purchases don't have request IDs
      })
    }
  }
  
  // Convert to array and format
  const summaries: MonthlyPurchaseSummary[] = Array.from(monthlyData.values())
    .map(data => ({
      year: data.year,
      month: data.month,
      monthName: new Date(data.year, data.month - 1, 1).toLocaleString('default', { month: 'long' }),
      totalValue: data.totalValue,
      totalItems: data.totalItems,
      requestCount: data.requestIds.size,
    }))
    .sort((a, b) => {
      if (a.year !== b.year) return b.year - a.year
      return b.month - a.month
    })
  
  return summaries
}

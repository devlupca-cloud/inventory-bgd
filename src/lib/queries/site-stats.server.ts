import { createServerSupabaseClient } from '@/lib/supabase/server'

export interface SiteStats {
  totalSpent: number // Total gasto em compras para este site
  totalItemsPurchased: number // Quantidade total de itens comprados
  totalDistributions: number // Número de distribuições recebidas
  lastPurchaseDate: string | null // Data da última compra/distribuição
}

/**
 * Get purchase and distribution statistics for a specific site
 */
export async function getSiteStats(siteId: string): Promise<SiteStats> {
  const supabase = await createServerSupabaseClient()
  
  // Get purchase request items that were distributed to this site
  // We'll track via stock_movements where items were transferred TO this site
  // and the notes mention purchase request distribution
  
  // Get all transfers TO this site that came from purchase requests (distributions)
  const { data: transfers, error: transfersError } = await supabase
    .from('stock_movements')
    .select(`
      id,
      product_id,
      quantity,
      notes,
      created_at
    `)
    .eq('movement_type', 'TRANSFER_IN')
    .eq('site_id', siteId)
    .or('notes.ilike.%Purchase from request%,notes.ilike.%Distribution from purchase request%')
    .order('created_at', { ascending: false })
  
  if (transfersError) throw transfersError

  // Get purchase request items where this site was the target
  const { data: purchaseItems, error: purchaseItemsError } = await supabase
    .from('purchase_request_items')
    .select(`
      id,
      quantity_received,
      unit_price,
      purchase_request_id,
      purchase_request:purchase_requests!inner(
        id,
        updated_at,
        status
      )
    `)
    .eq('target_site_id', siteId)
    .gt('quantity_received', 0)
    .in('purchase_request.status', ['fulfilled', 'partially_fulfilled'])
  
  if (purchaseItemsError) throw purchaseItemsError

  // Calculate stats from purchase request items (more accurate)
  let totalSpent = 0
  let totalItemsPurchased = 0
  let lastPurchaseDate: string | null = null

  if (purchaseItems && purchaseItems.length > 0) {
    for (const item of purchaseItems) {
      const itemData = item as any
      const quantityReceived = itemData.quantity_received || 0
      const unitPrice = itemData.unit_price || 0
      
      totalItemsPurchased += quantityReceived
      totalSpent += quantityReceived * unitPrice
      
      // Get the most recent purchase date
      const requestDate = itemData.purchase_request?.updated_at
      if (requestDate && (!lastPurchaseDate || requestDate > lastPurchaseDate)) {
        lastPurchaseDate = requestDate
      }
    }
  }

  // Count unique distributions (by purchase request)
  let totalDistributions = 0
  const uniqueRequests = new Set(
    (purchaseItems || []).map((item: any) => item.purchase_request_id)
  )
  totalDistributions = uniqueRequests.size

  // If we have transfers but no purchase items with target_site_id, 
  // use transfers to estimate (some distributions might not have target_site_id set)
  if (transfers && transfers.length > 0) {
    // Count unique purchase requests from transfer notes
    const transferRequestIds = new Set(
      transfers
        .map((t: any) => {
          // Extract purchase request ID from notes
          const match = t.notes?.match(/(?:purchase request|request)\s+([a-f0-9-]{8,})/i)
          return match ? match[1] : null
        })
        .filter(Boolean)
    )
    
    // Use transfers if we got more distributions from them, or if we have no purchase items
    if (transferRequestIds.size > totalDistributions || totalDistributions === 0) {
      totalDistributions = transferRequestIds.size
    }

    // Update last purchase date if transfers are more recent
    if (transfers.length > 0) {
      const transferDate = transfers[0].created_at
      if (!lastPurchaseDate || transferDate > lastPurchaseDate) {
        lastPurchaseDate = transferDate
      }
    }
  }

  return {
    totalSpent,
    totalItemsPurchased,
    totalDistributions,
    lastPurchaseDate,
  }
}

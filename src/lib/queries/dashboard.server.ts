import { createServerSupabaseClient } from '@/lib/supabase/server'

export interface LowStockAlert {
  site_id: string
  site_name: string
  product_id: string
  product_name: string
  quantity_on_hand: number
  min_level: number
  shortage: number
}

export interface PendingRequest {
  id: string
  site_id: string
  site_name: string
  status: string
  requested_by_name: string | null
  requested_by_email: string
  created_at: string
  item_count: number
}

export interface RecentMovement {
  id: string
  site_id: string
  site_name: string
  product_id: string
  product_name: string
  movement_type: 'IN' | 'OUT' | 'TRANSFER_IN' | 'TRANSFER_OUT'
  quantity: number
  created_at: string
  created_by_email: string | null
}

export interface SiteSummary {
  id: string
  name: string
  address: string | null
  total_products: number
  low_stock_count: number
  last_movement: string | null
}

export async function getDashboardData() {
  const supabase = await createServerSupabaseClient()
  
  // Get low stock alerts (top 5)
  const { data: lowStockAlerts } = await supabase
    .from('low_stock_alerts')
    .select('*')
    .order('shortage', { ascending: false })
    .limit(5)

  // Get pending purchase requests (submitted, waiting approval)
  const { data: pendingRequests } = await supabase
    .from('purchase_requests')
    .select(`
      id,
      site_id,
      status,
      created_at,
      site:sites(name),
      requested_by_user:user_profiles!purchase_requests_requested_by_fkey(full_name, email),
      purchase_request_items(count)
    `)
    .in('status', ['submitted', 'approved'])
    .order('created_at', { ascending: false })
    .limit(5)

  // Get recent stock movements
  const { data: recentMovements } = await supabase
    .from('stock_movements')
    .select(`
      id,
      site_id,
      product_id,
      movement_type,
      quantity,
      created_at,
      site:sites(name),
      product:products(name),
      created_by_user:user_profiles!stock_movements_created_by_fkey(email)
    `)
    .order('created_at', { ascending: false })
    .limit(10)

  // Get site summaries
  const { data: sites } = await supabase
    .from('sites')
    .select('id, name, address')
    .order('name')

  // Get inventory counts per site
  const { data: inventoryCounts } = await supabase
    .from('site_inventory')
    .select('site_id')
  
  // Get low stock counts per site
  const { data: lowStockCounts } = await supabase
    .from('low_stock_alerts')
    .select('site_id')

  // Get last movement per site
  const { data: lastMovements } = await supabase
    .from('stock_movements')
    .select('site_id, created_at')
    .order('created_at', { ascending: false })

  // Build site summaries
  const siteSummaries: SiteSummary[] = (sites || []).map(site => {
    const productCount = (inventoryCounts || []).filter(i => i.site_id === site.id).length
    const lowCount = (lowStockCounts || []).filter(l => l.site_id === site.id).length
    const lastMov = (lastMovements || []).find(m => m.site_id === site.id)
    
    return {
      id: site.id,
      name: site.name,
      address: site.address,
      total_products: productCount,
      low_stock_count: lowCount,
      last_movement: lastMov?.created_at || null
    }
  })

  // Format pending requests
  const formattedPendingRequests: PendingRequest[] = (pendingRequests || []).map((req: Record<string, unknown>) => ({
    id: req.id as string,
    site_id: req.site_id as string,
    site_name: (req.site as { name: string })?.name || 'Unknown',
    status: req.status as string,
    requested_by_name: (req.requested_by_user as { full_name: string | null })?.full_name || null,
    requested_by_email: (req.requested_by_user as { email: string })?.email || 'Unknown',
    created_at: req.created_at as string,
    item_count: Array.isArray(req.purchase_request_items) ? req.purchase_request_items.length : 0
  }))

  // Format recent movements
  const formattedMovements: RecentMovement[] = (recentMovements || []).map((mov: Record<string, unknown>) => ({
    id: mov.id as string,
    site_id: mov.site_id as string,
    site_name: (mov.site as { name: string })?.name || 'Unknown',
    product_id: mov.product_id as string,
    product_name: (mov.product as { name: string })?.name || 'Unknown',
    movement_type: mov.movement_type as 'IN' | 'OUT' | 'TRANSFER_IN' | 'TRANSFER_OUT',
    quantity: mov.quantity as number,
    created_at: mov.created_at as string,
    created_by_email: (mov.created_by_user as { email: string })?.email || null
  }))

  return {
    lowStockAlerts: (lowStockAlerts || []) as LowStockAlert[],
    pendingRequests: formattedPendingRequests,
    recentMovements: formattedMovements,
    siteSummaries,
    stats: {
      totalAlerts: (lowStockAlerts || []).length,
      totalPendingRequests: formattedPendingRequests.length,
      totalSites: (sites || []).length
    }
  }
}

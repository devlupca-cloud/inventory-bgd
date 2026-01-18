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
  const { data: pendingRequestsData } = await supabase
    .from('purchase_requests')
    .select(`
      id,
      site_id,
      status,
      created_at,
      requested_by,
      site:sites(name)
    `)
    .in('status', ['submitted', 'approved'])
    .order('created_at', { ascending: false })
    .limit(5)
  
  // Get item counts for each request
  const requestIds = (pendingRequestsData || []).map(r => r.id)
  const { data: itemCounts } = requestIds.length > 0 ? await supabase
    .from('purchase_request_items')
    .select('purchase_request_id')
    .in('purchase_request_id', requestIds) : { data: [] }
  
  // Get user profiles
  const requestedByIds = [...new Set((pendingRequestsData || []).map(r => r.requested_by).filter(Boolean))]
  const { data: users } = requestedByIds.length > 0 ? await supabase
    .from('user_profiles')
    .select('id, email, full_name')
    .in('id', requestedByIds) : { data: [] }
  
  const userMap = new Map((users || []).map(u => [u.id, u]))
  const countMap = new Map()
  ;(itemCounts || []).forEach(item => {
    countMap.set(item.purchase_request_id, (countMap.get(item.purchase_request_id) || 0) + 1)
  })
  
  const pendingRequests = (pendingRequestsData || []).map(req => ({
    id: req.id,
    site_id: req.site_id,
    status: req.status,
    created_at: req.created_at,
    site: req.site,
    requested_by_user: userMap.get(req.requested_by) || { email: 'Unknown', full_name: null },
    item_count: countMap.get(req.id) || 0
  }))

  // Get recent stock movements
  const { data: movementsData } = await supabase
    .from('stock_movements')
    .select(`
      id,
      site_id,
      product_id,
      movement_type,
      quantity,
      created_at,
      created_by,
      site:sites(name),
      product:products(name)
    `)
    .order('created_at', { ascending: false })
    .limit(10)
  
  // Get user profiles for movements
  const createdByIds = [...new Set((movementsData || []).map(m => m.created_by).filter(Boolean))]
  const { data: movementUsers } = createdByIds.length > 0 ? await supabase
    .from('user_profiles')
    .select('id, email')
    .in('id', createdByIds) : { data: [] }
  
  const movementUserMap = new Map((movementUsers || []).map(u => [u.id, u]))
  
  const recentMovements = (movementsData || []).map(mov => ({
    id: mov.id,
    site_id: mov.site_id,
    product_id: mov.product_id,
    movement_type: mov.movement_type,
    quantity: mov.quantity,
    created_at: mov.created_at,
    site: mov.site,
    product: mov.product,
    created_by_email: movementUserMap.get(mov.created_by)?.email || null
  }))

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
  const formattedPendingRequests: PendingRequest[] = pendingRequests.map(req => ({
    id: req.id,
    site_id: req.site_id,
    site_name: req.site?.name || 'Unknown',
    status: req.status,
    requested_by_name: req.requested_by_user?.full_name || null,
    requested_by_email: req.requested_by_user?.email || 'Unknown',
    created_at: req.created_at,
    item_count: req.item_count
  }))

  // Format recent movements
  const formattedMovements: RecentMovement[] = recentMovements.map(mov => ({
    id: mov.id,
    site_id: mov.site_id,
    site_name: mov.site?.name || 'Unknown',
    product_id: mov.product_id,
    product_name: mov.product?.name || 'Unknown',
    movement_type: mov.movement_type,
    quantity: mov.quantity,
    created_at: mov.created_at,
    created_by_email: mov.created_by_email
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

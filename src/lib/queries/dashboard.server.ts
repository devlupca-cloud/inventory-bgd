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
  is_master?: boolean
}

export interface DashboardStats {
  totalAlerts: number
  totalPendingRequests: number
  totalSites: number
  monthlySpending: number
  pendingDistributions: number
  fulfilledRequests: number
}

export interface MasterSiteInfo {
  id: string
  name: string
  total_products: number
}

export interface DashboardData {
  lowStockAlerts: LowStockAlert[]
  pendingRequests: PendingRequest[]
  recentMovements: RecentMovement[]
  siteSummaries: SiteSummary[]
  masterSite: MasterSiteInfo | null
  stats: DashboardStats
}

export async function getDashboardData(): Promise<DashboardData> {
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
  const requestIds = (pendingRequestsData || []).map((r: { id: string }) => r.id)
  const { data: itemCounts } = requestIds.length > 0 ? await supabase
    .from('purchase_request_items')
    .select('purchase_request_id')
    .in('purchase_request_id', requestIds) : { data: [] }
  
  // Get user profiles
  const requestedByIds = [...new Set((pendingRequestsData || []).map((r: { requested_by: string }) => r.requested_by).filter(Boolean))]
  const { data: users } = requestedByIds.length > 0 ? await supabase
    .from('user_profiles')
    .select('id, email, full_name')
    .in('id', requestedByIds) : { data: [] }
  
  const userMap = new Map((users || []).map((u: { id: string; email: string; full_name: string | null }) => [u.id, u]))
  const countMap = new Map<string, number>()
  ;(itemCounts || []).forEach((item: { purchase_request_id: string }) => {
    countMap.set(item.purchase_request_id, (countMap.get(item.purchase_request_id) || 0) + 1)
  })
  
  const pendingRequests = (pendingRequestsData || []).map((req: any) => ({
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
  const createdByIds = [...new Set((movementsData || []).map((m: { created_by: string }) => m.created_by).filter(Boolean))]
  const { data: movementUsers } = createdByIds.length > 0 ? await supabase
    .from('user_profiles')
    .select('id, email')
    .in('id', createdByIds) : { data: [] }
  
  const movementUserMap = new Map((movementUsers || []).map((u: { id: string; email: string }) => [u.id, u]))
  
  const recentMovements = (movementsData || []).map((mov: any) => ({
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
    .select('id, name, address, is_master')
    .is('deleted_at', null)
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

  // Build site summaries (exclude master from regular sites list)
  const siteSummaries: SiteSummary[] = (sites || [])
    .filter((site: { is_master: boolean }) => !site.is_master)
    .map((site: { id: string; name: string; address: string | null; is_master: boolean }) => {
      const productCount = (inventoryCounts || []).filter((i: { site_id: string }) => i.site_id === site.id).length
      const lowCount = (lowStockCounts || []).filter((l: { site_id: string }) => l.site_id === site.id).length
      const lastMov = (lastMovements || []).find((m: { site_id: string }) => m.site_id === site.id)
      
      return {
        id: site.id,
        name: site.name,
        address: site.address,
        total_products: productCount,
        low_stock_count: lowCount,
        last_movement: (lastMov as { created_at: string } | undefined)?.created_at || null,
        is_master: false
      }
    })
  
  // Get master site info
  const masterSite = (sites || []).find((site: { is_master: boolean }) => site.is_master)
  
  // Get monthly spending (current month)
  const now = new Date()
  const startOfMonth = new Date(now.getFullYear(), now.getMonth(), 1)
  const endOfMonth = new Date(now.getFullYear(), now.getMonth() + 1, 0, 23, 59, 59)
  
  // Get fulfilled purchase requests this month
  const { data: fulfilledRequests } = await supabase
    .from('purchase_requests')
    .select('id')
    .in('status', ['fulfilled', 'partially_fulfilled'])
    .gte('updated_at', startOfMonth.toISOString())
    .lte('updated_at', endOfMonth.toISOString())
    .is('deleted_at', null)
  
  // Get purchase request items received this month
  const fulfilledRequestIds = (fulfilledRequests || []).map((r: { id: string }) => r.id)
  const { data: monthlyItems } = fulfilledRequestIds.length > 0 ? await supabase
    .from('purchase_request_items')
    .select('quantity_received, unit_price')
    .in('purchase_request_id', fulfilledRequestIds)
    .gt('quantity_received', 0) : { data: [] }
  
  // Get direct purchases this month
  const { data: directPurchases } = await supabase
    .from('direct_purchases')
    .select('total_value')
    .gte('purchased_at', startOfMonth.toISOString())
    .lte('purchased_at', endOfMonth.toISOString())
    .is('deleted_at', null)
  
  // Calculate monthly spending
  const requestSpending = (monthlyItems || []).reduce((sum: number, item: { quantity_received: number; unit_price: number | null }) => {
    return sum + (item.quantity_received * (item.unit_price || 0))
  }, 0)
  
  const directSpending = (directPurchases || []).reduce((sum: number, purchase: { total_value: number }) => {
    return sum + (purchase.total_value || 0)
  }, 0)
  
  const monthlySpending = requestSpending + directSpending
  
  // Get pending distributions (fulfilled requests that haven't been fully distributed)
  const { data: distributionRequests } = await supabase
    .from('purchase_requests')
    .select('id')
    .in('status', ['fulfilled', 'partially_fulfilled'])
    .is('deleted_at', null)
  
  // For now, we'll count fulfilled requests as potential distributions
  // In a more sophisticated system, we'd check if items are still in master
  const pendingDistributions = (distributionRequests || []).length

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
    masterSite: masterSite ? {
      id: masterSite.id,
      name: masterSite.name,
      total_products: (inventoryCounts || []).filter((i: { site_id: string }) => i.site_id === masterSite.id).length,
      total_items: 0 // Will be calculated if needed
    } : null,
    stats: {
      totalAlerts: (lowStockAlerts || []).length,
      totalPendingRequests: formattedPendingRequests.length,
      totalSites: siteSummaries.length,
      monthlySpending,
      pendingDistributions,
      fulfilledRequests: (fulfilledRequests || []).length
    }
  }
}

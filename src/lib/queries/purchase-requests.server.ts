import { createServerSupabaseClient } from '@/lib/supabase/server'

export interface PurchaseRequest {
  id: string
  site_id: string
  status: 'draft' | 'submitted' | 'approved' | 'rejected' | 'fulfilled' | 'partially_fulfilled'
  requested_by: string
  approved_by: string | null
  approved_at: string | null
  notes: string | null
  created_at: string
  updated_at: string
  site: {
    id: string
    name: string
  }
  requested_by_user: {
    id: string
    email: string
    full_name: string | null
  }
  approved_by_user?: {
    id: string
    email: string
    full_name: string | null
  } | null
  // Aggregated stats
  total_items?: number
  total_value_estimated?: number
  total_value_spent?: number
}

export interface PurchaseRequestItem {
  id: string
  purchase_request_id: string
  product_id: string
  quantity_requested: number
  quantity_received: number
  unit_price: number | null
  current_quantity_observed: number | null
  notes: string | null
  target_site_id: string | null
  product: {
    id: string
    name: string
    unit: string
    price: number
  }
  target_site?: {
    id: string
    name: string
  } | null
}

export async function getPurchaseRequests(): Promise<PurchaseRequest[]> {
  const supabase = await createServerSupabaseClient()
  
  // First get purchase requests
  const { data: requests, error: requestsError } = await supabase
    .from('purchase_requests')
    .select(`
      *,
      site:sites(id, name)
    `)
    .is('deleted_at', null)
    .order('created_at', { ascending: false })
  
  if (requestsError) throw requestsError
  if (!requests || requests.length === 0) return []
  
  // Get user profiles for all requested_by IDs
  const requestedByIds = [...new Set(requests.map((r: { requested_by: string }) => r.requested_by).filter(Boolean))]
  const { data: users, error: usersError } = await supabase
    .from('user_profiles')
    .select('id, email, full_name')
    .in('id', requestedByIds)
  
  if (usersError) throw usersError
  
  // Map users to requests
  const userMap = new Map((users || []).map((u: { id: string; email: string; full_name: string | null }) => [u.id, u]))
  
  // Get items for all requests to calculate totals
  const requestIds = requests.map((r: { id: string }) => r.id)
  const { data: allItems, error: itemsError } = await supabase
    .from('purchase_request_items')
    .select('purchase_request_id, quantity_requested, quantity_received, unit_price, notes')
    .in('purchase_request_id', requestIds)
  
  if (itemsError) throw itemsError
  
  // Group items by request_id
  const itemsByRequest = new Map<string, any[]>()
  allItems?.forEach((item: any) => {
    const requestId = item.purchase_request_id
    if (!itemsByRequest.has(requestId)) {
      itemsByRequest.set(requestId, [])
    }
    // Exclude "soft removed" items
    if (!item.notes || !String(item.notes).startsWith('__REMOVED__')) {
      itemsByRequest.get(requestId)!.push(item)
    }
  })
  
  return (requests || []).map((request: any) => {
    const items = itemsByRequest.get(request.id) || []
    const totalItems = items.length
    const totalValueEstimated = items.reduce((sum: number, item: any) => 
      sum + (item.quantity_requested || 0) * (item.unit_price || 0), 0
    )
    const totalValueSpent = items.reduce((sum: number, item: any) => 
      sum + (item.quantity_received || 0) * (item.unit_price || 0), 0
    )
    
    return {
      ...request,
      requested_by_user: userMap.get(request.requested_by) || {
        id: request.requested_by,
        email: 'Unknown',
        full_name: null
      },
      total_items: totalItems,
      total_value_estimated: totalValueEstimated,
      total_value_spent: totalValueSpent,
    }
  })
}

export async function getPurchaseRequest(requestId: string): Promise<PurchaseRequest | null> {
  const supabase = await createServerSupabaseClient()
  
  // Get purchase request
  const { data: request, error: requestError } = await supabase
    .from('purchase_requests')
    .select(`
      *,
      site:sites(id, name)
    `)
    .eq('id', requestId)
    .is('deleted_at', null)
    .maybeSingle()
  
  if (requestError) throw requestError
  if (!request) return null
  
  // Get user profiles for requested_by and approved_by
  const requestData = request as any
  const userIds = [requestData.requested_by]
  if (requestData.approved_by) {
    userIds.push(requestData.approved_by)
  }
  
  const { data: users, error: usersError } = await supabase
    .from('user_profiles')
    .select('id, email, full_name')
    .in('id', userIds)
  
  if (usersError) throw usersError
  
  const userMap = new Map((users || []).map((u: { id: string; email: string; full_name: string | null }) => [u.id, u]))
  
  return {
    ...requestData,
    requested_by_user: userMap.get(requestData.requested_by) || {
      id: requestData.requested_by,
      email: 'Unknown',
      full_name: null
    },
    approved_by_user: requestData.approved_by ? (userMap.get(requestData.approved_by) || {
      id: requestData.approved_by,
      email: 'Unknown',
      full_name: null
    }) : null
  }
}

export async function getPurchaseRequestItems(requestId: string): Promise<PurchaseRequestItem[]> {
  const supabase = await createServerSupabaseClient()
  const { data, error } = await supabase
    .from('purchase_request_items')
    .select(`
      *,
      product:products(*),
      target_site:sites(id, name)
    `)
    .eq('purchase_request_id', requestId)
    .order('id')
  
  if (error) throw error
  // Hide "soft removed" items
  return (data || []).filter((item: any) => !item.notes || !String(item.notes).startsWith('__REMOVED__'))
}

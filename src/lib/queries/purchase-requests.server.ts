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
  product: {
    id: string
    name: string
    unit: string
    price: number
  }
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
  const requestedByIds = [...new Set(requests.map(r => r.requested_by).filter(Boolean))]
  const { data: users, error: usersError } = await supabase
    .from('user_profiles')
    .select('id, email, full_name')
    .in('id', requestedByIds)
  
  if (usersError) throw usersError
  
  // Map users to requests
  const userMap = new Map((users || []).map(u => [u.id, u]))
  
  return (requests || []).map(request => ({
    ...request,
    requested_by_user: userMap.get(request.requested_by) || {
      id: request.requested_by,
      email: 'Unknown',
      full_name: null
    }
  }))
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
  const userIds = [request.requested_by]
  if (request.approved_by) {
    userIds.push(request.approved_by)
  }
  
  const { data: users, error: usersError } = await supabase
    .from('user_profiles')
    .select('id, email, full_name')
    .in('id', userIds)
  
  if (usersError) throw usersError
  
  const userMap = new Map((users || []).map(u => [u.id, u]))
  
  return {
    ...request,
    requested_by_user: userMap.get(request.requested_by) || {
      id: request.requested_by,
      email: 'Unknown',
      full_name: null
    },
    approved_by_user: request.approved_by ? (userMap.get(request.approved_by) || {
      id: request.approved_by,
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
      product:products(*)
    `)
    .eq('purchase_request_id', requestId)
    .order('id')
  
  if (error) throw error
  return data || []
}

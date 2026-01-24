import { createClient } from '@/lib/supabase/client'

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
  target_site_id: string | null
  product: {
    id: string
    name: string
    unit: string
    price: number | null
  }
  target_site?: {
    id: string
    name: string
  } | null
}

export async function getPurchaseRequests(): Promise<PurchaseRequest[]> {
  const supabase = createClient()
  const { data, error } = await supabase
    .from('purchase_requests')
    .select(`
      *,
      site:sites(id, name),
      requested_by_user:user_profiles!purchase_requests_requested_by_fkey(id, email, full_name)
    `)
    .order('created_at', { ascending: false })
  
  if (error) throw error
  return data || []
}

export async function getPurchaseRequest(requestId: string): Promise<PurchaseRequest | null> {
  const supabase = createClient()
  const { data, error } = await supabase
    .from('purchase_requests')
    .select(`
      *,
      site:sites(id, name),
      requested_by_user:user_profiles!purchase_requests_requested_by_fkey(id, email, full_name)
    `)
    .eq('id', requestId)
    .single()
  
  if (error) throw error
  return data
}

export async function getPurchaseRequestItems(requestId: string): Promise<PurchaseRequestItem[]> {
  const supabase = createClient()
  const { data, error } = await supabase
    .from('purchase_request_items')
    .select(`
      *,
      product:products(*)
    `)
    .eq('purchase_request_id', requestId)
    .order('id')
  
  if (error) throw error
  return (data || []).filter((item: any) => !item.notes || !String(item.notes).startsWith('__REMOVED__'))
}

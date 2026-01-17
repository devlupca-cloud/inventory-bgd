import { createClient } from '@/lib/supabase/client'

export async function approvePurchaseRequest(requestId: string) {
  const supabase = createClient()
  const { data, error } = await supabase.rpc('rpc_approve_purchase_request', {
    p_request_id: requestId,
  })
  
  if (error) throw error
  return data
}

export interface ItemReceived {
  item_id: string
  quantity_received: number
  unit_price?: number | null
}

export async function receivePurchaseRequest(
  requestId: string,
  itemsReceived: ItemReceived[]
) {
  const supabase = createClient()
  const { data, error } = await supabase.rpc('rpc_receive_purchase_request', {
    p_request_id: requestId,
    p_items_received: itemsReceived,
  })
  
  if (error) throw error
  return data
}

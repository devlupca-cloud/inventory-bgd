import { createClient } from '@/lib/supabase/client'

export async function approvePurchaseRequest(
  requestId: string, 
  adjustStock: boolean = false
): Promise<{ success: boolean; message?: string }> {
  const supabase = createClient()
  const { data, error } = await supabase.rpc('rpc_approve_purchase_request', {
    p_request_id: requestId,
    p_adjust_stock: adjustStock,
  } as any)
  
  if (error) {
    return { success: false, message: error.message }
  }
  return data || { success: false, message: 'Unknown error' }
}

export interface ItemReceived {
  item_id: string
  quantity_received: number
  unit_price?: number | null
}

export async function receivePurchaseRequest(
  requestId: string,
  itemsReceived: ItemReceived[]
): Promise<{ success: boolean; message?: string }> {
  const supabase = createClient()
  const { data, error } = await supabase.rpc('rpc_receive_purchase_request', {
    p_request_id: requestId,
    p_items_received: itemsReceived,
  } as any)
  
  if (error) {
    return { success: false, message: error.message }
  }
  return data || { success: false, message: 'Unknown error' }
}

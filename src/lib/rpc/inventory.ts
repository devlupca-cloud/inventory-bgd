import { createClient } from '@/lib/supabase/client'

export async function registerIn(
  siteId: string,
  productId: string,
  quantity: number,
  notes?: string
) {
  const supabase = createClient()
  const { data, error } = await supabase.rpc('rpc_register_in', {
    p_site_id: siteId,
    p_product_id: productId,
    p_quantity: quantity,
    p_notes: notes || null,
  })
  
  if (error) throw error
  return data
}

export async function registerOut(
  siteId: string,
  productId: string,
  quantity: number,
  notes?: string
): Promise<{ success: boolean; message?: string }> {
  const supabase = createClient()
  const { data, error } = await supabase.rpc('rpc_register_out', {
    p_site_id: siteId,
    p_product_id: productId,
    p_quantity: quantity,
    p_notes: notes || null,
  })
  
  if (error) {
    return { success: false, message: error.message }
  }
  return data || { success: false, message: 'Unknown error' }
}

export async function transferBetweenSites(
  fromSiteId: string,
  toSiteId: string,
  productId: string,
  quantity: number,
  notes?: string
): Promise<{ success: boolean; message?: string }> {
  const supabase = createClient()
  const { data, error } = await supabase.rpc('rpc_transfer_between_sites', {
    p_from_site_id: fromSiteId,
    p_to_site_id: toSiteId,
    p_product_id: productId,
    p_quantity: quantity,
    p_notes: notes || null,
  })
  
  if (error) {
    return { success: false, message: error.message }
  }
  return data || { success: false, message: 'Unknown error' }
}

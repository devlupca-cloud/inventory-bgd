import { createServerSupabaseClient } from '@/lib/supabase/server'
import { getMasterSite } from '@/lib/queries/sites.server'

export interface DirectPurchase {
  id: string
  product_id: string
  quantity_purchased: number
  unit_price: number
  total_value: number
  purchased_by: string
  purchased_at: string
  notes: string | null
  created_at: string
  updated_at: string
  product: {
    id: string
    name: string
    unit: string
  }
  purchased_by_user: {
    id: string
    email: string
    full_name: string | null
  }
}

export async function getDirectPurchases(
  year?: number,
  month?: number
): Promise<DirectPurchase[]> {
  const supabase = await createServerSupabaseClient()
  
  let query = supabase
    .from('direct_purchases')
    .select(`
      *,
      product:products(id, name, unit),
      purchased_by_user:user_profiles(id, email, full_name)
    `)
    .is('deleted_at', null)
    .order('purchased_at', { ascending: false })
  
  // Filter by month if provided
  if (year && month) {
    const startDate = new Date(year, month - 1, 1)
    const endDate = new Date(year, month, 0, 23, 59, 59)
    query = query
      .gte('purchased_at', startDate.toISOString())
      .lte('purchased_at', endDate.toISOString())
  }
  
  const { data, error } = await query
  
  if (error) throw error
  return data || []
}

export async function createDirectPurchase(
  productId: string,
  quantity: number,
  unitPrice: number,
  notes?: string
): Promise<{ success: boolean; message?: string; purchaseId?: string }> {
  const supabase = await createServerSupabaseClient()
  
  // Get current user
  const { data: { user }, error: userError } = await supabase.auth.getUser()
  if (userError || !user) {
    return { success: false, message: 'Not authenticated' }
  }
  
  // Get master site
  const masterSite = await getMasterSite()
  if (!masterSite) {
    return { success: false, message: 'Master warehouse not found' }
  }
  
  // Create direct purchase record
  const { data: purchase, error: purchaseError } = await supabase
    .from('direct_purchases')
    // @ts-expect-error - Supabase type inference issue
    .insert({
      product_id: productId,
      quantity_purchased: quantity,
      unit_price: unitPrice,
      purchased_by: user.id,
      notes: notes || null,
      purchased_at: new Date().toISOString(),
    })
    .select()
    .single()
  
  if (purchaseError) {
    return { success: false, message: purchaseError.message }
  }
  
  // Add items to master warehouse inventory via stock movement
  const { error: movementError } = await supabase
    .from('stock_movements')
    // @ts-expect-error - Supabase type inference issue
    .insert({
      site_id: masterSite.id,
      product_id: productId,
      movement_type: 'IN',
      quantity: quantity,
      notes: `Direct purchase (ID: ${purchase.id.substring(0, 8)}) - $ ${unitPrice.toFixed(2)}/unit`,
    })
  
  if (movementError) {
    // Rollback: delete the purchase record
    await supabase
      .from('direct_purchases')
      .update({ deleted_at: new Date().toISOString() })
      .eq('id', purchase.id)
    
    return { success: false, message: `Failed to add to inventory: ${movementError.message}` }
  }
  
  return { success: true, message: 'Direct purchase created successfully', purchaseId: purchase.id }
}

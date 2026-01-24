import { NextRequest, NextResponse } from 'next/server'
import { createServerSupabaseClient } from '@/lib/supabase/server'
import { getMasterSite } from '@/lib/queries/sites.server'

export async function POST(request: NextRequest) {
  try {
    const supabase = await createServerSupabaseClient()
    
    // Check authentication
    const { data: { user }, error: userError } = await supabase.auth.getUser()
    if (userError || !user) {
      return NextResponse.json(
        { success: false, message: 'Not authenticated' },
        { status: 401 }
      )
    }
    
    // Check if user is manager or owner
    const { data: profile } = await supabase
      .from('user_profiles')
      .select('role')
      .eq('id', user.id)
      .single() as { data: { role: string } | null }
    
    if (!profile || !['manager', 'owner'].includes(profile.role)) {
      return NextResponse.json(
        { success: false, message: 'Only managers can create direct purchases' },
        { status: 403 }
      )
    }
    
    const body = await request.json()
    const { product_id, quantity, unit_price, notes } = body
    
    if (!product_id || !quantity || unit_price === undefined) {
      return NextResponse.json(
        { success: false, message: 'Missing required fields' },
        { status: 400 }
      )
    }
    
    // Get product info
    const { data: selectedProduct } = await supabase
      .from('products')
      .select('name, unit')
      .eq('id', product_id)
      .single()
    
    if (!selectedProduct) {
      return NextResponse.json(
        { success: false, message: 'Product not found' },
        { status: 404 }
      )
    }
    
    // Get master site
    const masterSite = await getMasterSite()
    if (!masterSite) {
      return NextResponse.json(
        { success: false, message: 'Master warehouse not found' },
        { status: 404 }
      )
    }
    
    // Create direct purchase record
    const { data: purchase, error: purchaseError } = await supabase
      .from('direct_purchases')
      // @ts-expect-error - Supabase type inference issue
      .insert({
        product_id,
        quantity_purchased: quantity,
        unit_price: unit_price,
        purchased_by: user.id,
        notes: notes || null,
        purchased_at: new Date().toISOString(),
      })
      .select()
      .single() as { data: { id: string } | null; error: any }
    
    if (purchaseError) {
      return NextResponse.json(
        { success: false, message: purchaseError.message },
        { status: 500 }
      )
    }
    
    if (!purchase) {
      return NextResponse.json(
        { success: false, message: 'Failed to create purchase' },
        { status: 500 }
      )
    }
    
    // Add items to master warehouse inventory using RPC (handles packages correctly)
    const purchaseNotes = `Direct purchase (ID: ${purchase.id.substring(0, 8)}) - $ ${unit_price.toFixed(2)}/${selectedProduct?.unit || 'unit'}`
    
    // @ts-expect-error - Supabase RPC type inference issue
    const { data: registerResult, error: registerError } = await supabase.rpc('rpc_register_in', {
      p_site_id: masterSite.id,
      p_product_id: product_id,
      p_quantity: quantity, // This is in purchase units (packages/boxes)
      p_user_id: user.id,
      p_notes: purchaseNotes,
    })
    
    if (registerError) {
      return NextResponse.json(
        { success: false, message: `Failed to add to inventory: ${registerError.message}` },
        { status: 500 }
      )
    }
    
    if (!registerResult || !registerResult.success) {
      return NextResponse.json(
        { success: false, message: registerResult?.message || 'Failed to add to inventory' },
        { status: 500 }
      )
    }
    
    return NextResponse.json({
      success: true,
      message: 'Direct purchase created successfully',
      purchaseId: purchase.id,
    })
  } catch (error: any) {
    return NextResponse.json(
      { success: false, message: error.message || 'An error occurred' },
      { status: 500 }
    )
  }
}

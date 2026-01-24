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
      .single()
    
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
      .single()
    
    if (purchaseError) {
      return NextResponse.json(
        { success: false, message: purchaseError.message },
        { status: 500 }
      )
    }
    
    // Add items to master warehouse inventory via stock movement
    const { error: movementError } = await supabase
      .from('stock_movements')
      // @ts-expect-error - Supabase type inference issue
      .insert({
        site_id: masterSite.id,
        product_id,
        movement_type: 'IN',
        quantity: quantity,
        notes: `Direct purchase (ID: ${purchase.id.substring(0, 8)}) - R$ ${unit_price.toFixed(2)}/unit`,
      })
    
    if (movementError) {
      // Rollback: delete the purchase record
      await supabase
        .from('direct_purchases')
        .update({ deleted_at: new Date().toISOString() })
        .eq('id', purchase.id)
      
      return NextResponse.json(
        { success: false, message: `Failed to add to inventory: ${movementError.message}` },
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

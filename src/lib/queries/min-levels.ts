import { createClient } from '@/lib/supabase/client'

export interface MinLevel {
  site_id: string
  product_id: string
  min_level: number
  product_name?: string
  product_unit?: string
}

// Client-side function to get min levels for a site
export async function getSiteMinLevels(siteId: string): Promise<MinLevel[]> {
  const supabase = createClient()
  const { data, error } = await supabase
    .from('site_product_min_levels')
    .select(`
      *,
      product:products(name, unit)
    `)
    .eq('site_id', siteId)
  
  if (error) throw error
  
  return (data || []).map((item: any) => ({
    site_id: item.site_id,
    product_id: item.product_id,
    min_level: item.min_level,
    product_name: item.product?.name,
    product_unit: item.product?.unit,
  }))
}

// Client-side function to get min level for a specific site/product
export async function getMinLevel(siteId: string, productId: string): Promise<number | null> {
  const supabase = createClient()
  const { data, error } = await supabase
    .from('site_product_min_levels')
    .select('min_level')
    .eq('site_id', siteId)
    .eq('product_id', productId)
    .maybeSingle()
  
  if (error) throw error
  return (data as { min_level: number } | null)?.min_level || null
}

// Client-side function to set/update min level
export async function setMinLevel(
  siteId: string,
  productId: string,
  minLevel: number
): Promise<void> {
  const supabase = createClient()
  
  // Use upsert to insert or update
  const { error } = await supabase
    .from('site_product_min_levels')
    // @ts-expect-error - Supabase type inference issue
    .upsert({
      site_id: siteId,
      product_id: productId,
      min_level: minLevel,
    }, {
      onConflict: 'site_id,product_id'
    })
  
  if (error) throw error
}

// Client-side function to delete min level
export async function deleteMinLevel(siteId: string, productId: string): Promise<void> {
  const supabase = createClient()
  const { error } = await supabase
    .from('site_product_min_levels')
    .delete()
    .eq('site_id', siteId)
    .eq('product_id', productId)
  
  if (error) throw error
}

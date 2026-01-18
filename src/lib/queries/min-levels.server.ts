import { createServerSupabaseClient } from '@/lib/supabase/server'

export interface MinLevel {
  site_id: string
  product_id: string
  min_level: number
  product_name?: string
  product_unit?: string
}

// Server-side function to get min levels for a site
export async function getSiteMinLevelsServer(siteId: string): Promise<MinLevel[]> {
  const supabase = await createServerSupabaseClient()
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

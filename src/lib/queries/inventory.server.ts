import { createServerSupabaseClient } from '@/lib/supabase/server'

export interface SiteInventoryItem {
  site_id: string
  product_id: string
  quantity_on_hand: number
  last_updated: string
  product: {
    id: string
    name: string
    unit: string
    price: number
  }
  site: {
    id: string
    name: string
    address: string | null
    is_master: boolean
  }
}

export async function getSiteInventoryServer(siteId: string): Promise<SiteInventoryItem[]> {
  const supabase = await createServerSupabaseClient()
  const { data, error } = await supabase
    .from('site_inventory')
    .select(`
      *,
      product:products(*),
      site:sites(*)
    `)
    .eq('site_id', siteId)
    .order('product(name)')
  
  if (error) throw error
  return data || []
}

export interface LowStockAlert {
  site_id: string
  site_name: string
  product_id: string
  product_name: string
  quantity_on_hand: number
  min_level: number
  shortage: number
}

export async function getLowStockAlertsServer(): Promise<LowStockAlert[]> {
  const supabase = await createServerSupabaseClient()
  const { data, error } = await supabase
    .from('low_stock_alerts')
    .select('*')
    .order('shortage', { ascending: false })
  
  if (error) throw error
  return data || []
}

export async function getAllInventoryServer(): Promise<SiteInventoryItem[]> {
  const supabase = await createServerSupabaseClient()
  const { data, error } = await supabase
    .from('site_inventory')
    .select(`
      *,
      product:products(*),
      site:sites(*)
    `)
    .order('product(name), site(name)')
  
  if (error) throw error
  
  // Filter out master warehouse from the list
  // Master warehouse has its own dedicated page
  return (data || []).filter((item: any) => !item.site.is_master)
}

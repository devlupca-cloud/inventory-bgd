import { createClient } from '@/lib/supabase/client'

export interface SiteInventoryItem {
  site_id: string
  product_id: string
  quantity_on_hand: number
  last_updated: string
  product: {
    id: string
    name: string
    unit: string
  }
  site: {
    id: string
    name: string
    address: string | null
  }
}

export async function getSiteInventory(siteId: string): Promise<SiteInventoryItem[]> {
  const supabase = createClient()
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

export async function getLowStockAlerts(): Promise<LowStockAlert[]> {
  const supabase = createClient()
  const { data, error } = await supabase
    .from('low_stock_alerts')
    .select('*')
    .order('shortage', { ascending: false })
  
  if (error) throw error
  return data || []
}

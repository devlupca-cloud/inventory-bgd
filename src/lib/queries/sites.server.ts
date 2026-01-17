import { createServerSupabaseClient } from '@/lib/supabase/server'

export interface Site {
  id: string
  name: string
  address: string | null
  created_at: string
  updated_at: string
}

export async function getSites(): Promise<Site[]> {
  const supabase = await createServerSupabaseClient()
  const { data, error } = await supabase
    .from('sites')
    .select('*')
    .order('name')
  
  if (error) throw error
  return data || []
}

export async function getSiteServer(siteId: string): Promise<Site | null> {
  const supabase = await createServerSupabaseClient()
  const { data, error } = await supabase
    .from('sites')
    .select('*')
    .eq('id', siteId)
    .maybeSingle()
  
  if (error) throw error
  return data
}

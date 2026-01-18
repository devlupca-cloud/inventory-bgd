import { createServerSupabaseClient } from '@/lib/supabase/server'

export interface Site {
  id: string
  name: string
  address: string | null
  supervisor_name: string | null
  supervisor_phone: string | null
  is_master: boolean
  created_at: string
  updated_at: string
}

export async function getSites(includeMaster: boolean = false): Promise<Site[]> {
  const supabase = await createServerSupabaseClient()
  let query = supabase
    .from('sites')
    .select('*')
    .is('deleted_at', null)
  
  if (!includeMaster) {
    query = query.eq('is_master', false)
  }
  
  const { data, error } = await query
    .order('is_master', { ascending: false })
    .order('name')
  
  if (error) throw error
  return data || []
}

export async function getMasterSite(): Promise<Site | null> {
  const supabase = await createServerSupabaseClient()
  const { data, error } = await supabase
    .from('sites')
    .select('*')
    .eq('is_master', true)
    .is('deleted_at', null)
    .maybeSingle()
  
  if (error) throw error
  return data
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

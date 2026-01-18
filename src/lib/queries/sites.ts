import { createClient } from '@/lib/supabase/client'

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

// Client-side function
export async function getSites(): Promise<Site[]> {
  const supabase = createClient()
  const { data, error } = await supabase
    .from('sites')
    .select('*')
    .is('deleted_at', null)
    .order('name')
  
  if (error) throw error
  return data || []
}

// Client-side function
export async function getSite(siteId: string): Promise<Site | null> {
  const supabase = createClient()
  const { data, error } = await supabase
    .from('sites')
    .select('*')
    .eq('id', siteId)
    .maybeSingle()
  
  if (error) throw error
  return data
}

// Client-side function to get master site
export async function getMasterSite(): Promise<Site | null> {
  const supabase = createClient()
  const { data, error } = await supabase
    .from('sites')
    .select('*')
    .eq('is_master', true)
    .is('deleted_at', null)
    .maybeSingle()
  
  if (error) throw error
  return data
}

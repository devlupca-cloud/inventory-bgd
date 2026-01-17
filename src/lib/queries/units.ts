import { createClient } from '@/lib/supabase/client'

export interface Unit {
  id: string
  value: string
  label: string
  sort_order: number
  created_at: string
}

export async function getUnits(): Promise<Unit[]> {
  const supabase = createClient()
  const { data, error } = await supabase
    .from('units')
    .select('*')
    .order('sort_order')
  
  if (error) throw error
  return data || []
}

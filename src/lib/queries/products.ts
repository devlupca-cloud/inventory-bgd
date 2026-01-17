import { createClient } from '@/lib/supabase/client'

export interface Product {
  id: string
  name: string
  unit: string
  created_at: string
  updated_at: string
}

export async function getProducts(): Promise<Product[]> {
  const supabase = createClient()
  const { data, error } = await supabase
    .from('products')
    .select('*')
    .order('name')
  
  if (error) throw error
  return data || []
}

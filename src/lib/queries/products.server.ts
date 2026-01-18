import { createServerSupabaseClient } from '@/lib/supabase/server'

export interface Product {
  id: string
  name: string
  unit: string
  price: number
  created_at: string
  updated_at: string
}

export async function getProducts(): Promise<Product[]> {
  const supabase = await createServerSupabaseClient()
  const { data, error } = await supabase
    .from('products')
    .select('*')
    .order('name')
  
  if (error) throw error
  return data || []
}

export async function getProductServer(productId: string): Promise<Product | null> {
  const supabase = await createServerSupabaseClient()
  const { data, error } = await supabase
    .from('products')
    .select('*')
    .eq('id', productId)
    .maybeSingle()
  
  if (error) throw error
  return data
}

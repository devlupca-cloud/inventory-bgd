import { createClient } from '@/lib/supabase/client'

export interface Product {
  id: string
  name: string
  unit: string
  base_unit: string
  units_per_package: number
  price: number
  created_at: string
  updated_at: string
}

// Client-side function
export async function getProductsClient(): Promise<Product[]> {
  const supabase = createClient()
  const { data, error } = await supabase
    .from('products')
    .select('*')
    .order('name')
  
  if (error) throw error
  return data || []
}

// Client-side function
export async function getProduct(productId: string): Promise<Product | null> {
  const supabase = createClient()
  const { data, error } = await supabase
    .from('products')
    .select('*')
    .eq('id', productId)
    .maybeSingle()
  
  if (error) throw error
  return data
}

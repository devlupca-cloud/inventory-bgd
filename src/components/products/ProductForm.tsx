'use client'
import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Product } from '@/lib/queries/products'
import { getUnits, Unit } from '@/lib/queries/units'
import Input from '@/components/ui/Input'
import Select from '@/components/ui/Select'
import Button from '@/components/ui/Button'
import { useRouter } from 'next/navigation'

interface ProductFormProps {
  product?: Product
}

export default function ProductForm({ product }: ProductFormProps) {
  const [name, setName] = useState(product?.name || '')
  const [unit, setUnit] = useState(product?.unit || '')
  const [price, setPrice] = useState(product?.price?.toString() || '')
  const [units, setUnits] = useState<Unit[]>([])
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState(false)
  const supabase = createClient()
  const router = useRouter()
  const isEditing = !!product

  useEffect(() => {
    loadUnits()
  }, [])

  const loadUnits = async () => {
    try {
      const data = await getUnits()
      setUnits(data)
    } catch (err) {
      console.error('Error loading units:', err)
    }
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError('')
    setSuccess(false)

    if (!name.trim()) {
      setError('Product name is required')
      setLoading(false)
      return
    }

    if (!unit.trim()) {
      setError('Unit is required')
      setLoading(false)
      return
    }

    const priceValue = parseFloat(price) || 0
    if (priceValue < 0) {
      setError('Price cannot be negative')
      setLoading(false)
      return
    }

    try {
      if (isEditing) {
        const { error: updateError } = await supabase
          .from('products')
          // @ts-expect-error - Supabase type inference issue
          .update({
            name: name.trim(),
            unit: unit.trim(),
            price: priceValue,
          })
          .eq('id', product.id)

        if (updateError) throw updateError
      } else {
        const { error: insertError } = await supabase
          .from('products')
          // @ts-expect-error - Supabase type inference issue
          .insert({
            name: name.trim(),
            unit: unit.trim(),
            price: priceValue,
          })

        if (insertError) throw insertError
      }

      setSuccess(true)
      setTimeout(() => {
        router.push('/products')
        router.refresh()
      }, 1000)
    } catch (err: any) {
      setError(err.message || 'An error occurred')
    } finally {
      setLoading(false)
    }
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-5">
      <Input
        label="Product Name"
        type="text"
        value={name}
        onChange={(e) => setName(e.target.value)}
        placeholder="e.g., Paper Towels"
        required
      />

      <Select
        label="Unit"
        value={unit}
        onChange={(e) => setUnit(e.target.value)}
        required
      >
        <option value="">Select a unit</option>
        {units.map((u) => (
          <option key={u.id} value={u.value}>
            {u.label}
          </option>
        ))}
      </Select>

      <Input
        label="Price (R$)"
        type="number"
        step="0.01"
        min="0"
        value={price}
        onChange={(e) => setPrice(e.target.value)}
        placeholder="0.00"
      />

      {error && (
        <div className="bg-red-500/20 border border-red-500/30 text-red-400 px-4 py-3 rounded-lg text-sm">
          {error}
        </div>
      )}

      {success && (
        <div className="bg-green-500/20 border border-green-500/30 text-green-400 px-4 py-3 rounded-lg text-sm">
          Product {isEditing ? 'updated' : 'created'} successfully! Redirecting...
        </div>
      )}

      <div className="flex space-x-4">
        <Button type="submit" disabled={loading}>
          {loading ? 'Saving...' : isEditing ? 'Update Product' : 'Create Product'}
        </Button>
        <Button
          type="button"
          variant="secondary"
          onClick={() => router.push('/products')}
        >
          Cancel
        </Button>
      </div>
    </form>
  )
}

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
  const [baseUnit, setBaseUnit] = useState(product?.base_unit || '')
  const [unitsPerPackage, setUnitsPerPackage] = useState(product?.units_per_package?.toString() || '1')
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
      setError('Purchase unit is required')
      setLoading(false)
      return
    }

    if (!baseUnit.trim()) {
      setError('Distribution unit is required')
      setLoading(false)
      return
    }

    const unitsPerPkgValue = parseFloat(unitsPerPackage) || 1
    if (unitsPerPkgValue <= 0) {
      setError('Units per package must be greater than 0')
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
            base_unit: baseUnit.trim(),
            units_per_package: unitsPerPkgValue,
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
            base_unit: baseUnit.trim(),
            units_per_package: unitsPerPkgValue,
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
        placeholder="e.g., Mop Head"
        required
      />

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <Select
          label="Purchase Unit"
          value={unit}
          onChange={(e) => setUnit(e.target.value)}
          required
        >
          <option value="">Select purchase unit</option>
          {units.map((u) => (
            <option key={u.id} value={u.value}>
              {u.label}
            </option>
          ))}
        </Select>

        <Input
          label="Price per Purchase Unit ($)"
          type="number"
          step="0.01"
          min="0"
          value={price}
          onChange={(e) => setPrice(e.target.value)}
          placeholder="0.00"
        />
      </div>

      <div className="border border-neutral-700 rounded-lg p-4 bg-neutral-800/30">
        <h3 className="text-sm font-semibold text-white mb-3">Distribution Settings</h3>
        <p className="text-xs text-neutral-400 mb-4">
          Configure how this product can be distributed to sites. You can send full packages or individual units.
        </p>
        
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <Input
            label="Distribution Unit"
            type="text"
            value={baseUnit}
            onChange={(e) => setBaseUnit(e.target.value)}
            placeholder="e.g., unit, piece, bag"
            required
          />

          <Input
            label={`${baseUnit || 'Units'} per ${unit || 'Package'}`}
            type="number"
            step="0.01"
            min="0.01"
            value={unitsPerPackage}
            onChange={(e) => setUnitsPerPackage(e.target.value)}
            placeholder="e.g., 12"
            required
          />
        </div>

        {unit && baseUnit && unitsPerPackage && parseFloat(unitsPerPackage) > 0 && (
          <div className="mt-3 p-3 bg-green-500/10 border border-green-500/30 rounded text-xs text-green-400">
            <strong>Example:</strong> 1 {unit} = {unitsPerPackage} {baseUnit}
            {parseFloat(price) > 0 && (
              <>
                {' '}• Cost per {baseUnit}: $ {(parseFloat(price) / parseFloat(unitsPerPackage)).toFixed(2)}
              </>
            )}
          </div>
        )}
      </div>

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

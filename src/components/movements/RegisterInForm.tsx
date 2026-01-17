'use client'
import { useState, useEffect } from 'react'
import { registerIn } from '@/lib/rpc/inventory'
import SiteSelector from '@/components/inventory/SiteSelector'
import { getProducts, Product } from '@/lib/queries/products'
import Select from '@/components/ui/Select'
import Input from '@/components/ui/Input'
import Button from '@/components/ui/Button'
import { useRouter } from 'next/navigation'

export default function RegisterInForm() {
  const [siteId, setSiteId] = useState('')
  const [productId, setProductId] = useState('')
  const [quantity, setQuantity] = useState('')
  const [notes, setNotes] = useState('')
  const [products, setProducts] = useState<Product[]>([])
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState(false)
  const router = useRouter()

  useEffect(() => {
    loadProducts()
  }, [])

  const loadProducts = async () => {
    try {
      const data = await getProducts()
      setProducts(data)
    } catch (err) {
      console.error('Error loading products:', err)
    }
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError('')
    setSuccess(false)

    try {
      const result = await registerIn(
        siteId,
        productId,
        parseFloat(quantity),
        notes || undefined
      )

      if (result.success) {
        setSuccess(true)
        setTimeout(() => {
          router.push('/inventory')
          router.refresh()
        }, 1500)
      } else {
        setError(result.message || 'Failed to register stock')
      }
    } catch (err: any) {
      setError(err.message || 'An error occurred')
    } finally {
      setLoading(false)
    }
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-5">
      <SiteSelector value={siteId} onChange={setSiteId} />
      
      <Select
        label="Product"
        value={productId}
        onChange={(e) => setProductId(e.target.value)}
        required
      >
        <option value="">Select a product</option>
        {products.map((product) => (
          <option key={product.id} value={product.id}>
            {product.name} ({product.unit})
          </option>
        ))}
      </Select>

      <Input
        label="Quantity"
        type="number"
        step="0.01"
        min="0.01"
        value={quantity}
        onChange={(e) => setQuantity(e.target.value)}
        placeholder="Enter quantity"
        required
      />

      <Input
        label="Notes (optional)"
        type="text"
        value={notes}
        onChange={(e) => setNotes(e.target.value)}
        placeholder="Add any notes..."
      />

      {error && (
        <div className="bg-red-500/20 border border-red-500/30 text-red-400 px-4 py-3 rounded-lg text-sm">
          {error}
        </div>
      )}

      {success && (
        <div className="bg-green-500/20 border border-green-500/30 text-green-400 px-4 py-3 rounded-lg text-sm">
          Stock registered successfully! Redirecting...
        </div>
      )}

      <Button type="submit" disabled={loading || !siteId || !productId || !quantity} className="w-full">
        {loading ? 'Registering...' : 'Register Stock IN'}
      </Button>
    </form>
  )
}

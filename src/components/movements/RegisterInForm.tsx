'use client'
import { useState } from 'react'
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
    <form onSubmit={handleSubmit} className="space-y-4">
      <SiteSelector value={siteId} onChange={setSiteId} />
      
      {siteId && (
        <div>
          <button
            type="button"
            onClick={loadProducts}
            className="text-sm text-blue-600 hover:text-blue-800 mb-2"
          >
            Load Products
          </button>
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
        </div>
      )}

      <Input
        label="Quantity"
        type="number"
        step="0.01"
        min="0.01"
        value={quantity}
        onChange={(e) => setQuantity(e.target.value)}
        required
      />

      <Input
        label="Notes (optional)"
        type="text"
        value={notes}
        onChange={(e) => setNotes(e.target.value)}
      />

      {error && (
        <div className="bg-red-50 border border-red-200 text-red-800 px-4 py-3 rounded">
          {error}
        </div>
      )}

      {success && (
        <div className="bg-green-50 border border-green-200 text-green-800 px-4 py-3 rounded">
          Stock registered successfully! Redirecting...
        </div>
      )}

      <Button type="submit" disabled={loading || !siteId || !productId || !quantity}>
        {loading ? 'Registering...' : 'Register Stock IN'}
      </Button>
    </form>
  )
}

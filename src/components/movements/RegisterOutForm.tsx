'use client'
import { useState, useEffect } from 'react'
import { registerOut } from '@/lib/rpc/inventory'
import SiteSelector from '@/components/inventory/SiteSelector'
import { getProductsClient, Product } from '@/lib/queries/products'
import { getCurrentStock } from '@/lib/queries/inventory'
import Select from '@/components/ui/Select'
import Input from '@/components/ui/Input'
import Button from '@/components/ui/Button'
import { useRouter } from 'next/navigation'

interface RegisterOutFormProps {
  initialSiteId?: string
  initialProductId?: string
  onClose?: () => void
}

export default function RegisterOutForm({ initialSiteId = '', initialProductId = '', onClose }: RegisterOutFormProps) {
  const [siteId, setSiteId] = useState(initialSiteId)
  const [productId, setProductId] = useState(initialProductId)
  const [quantity, setQuantity] = useState('')
  const [notes, setNotes] = useState('')
  const [products, setProducts] = useState<Product[]>([])
  const [currentStock, setCurrentStock] = useState<number | null>(null)
  const [loadingStock, setLoadingStock] = useState(false)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState(false)
  const router = useRouter()

  useEffect(() => {
    loadProducts()
    if (initialSiteId) {
      setSiteId(initialSiteId)
    }
    if (initialProductId) {
      setProductId(initialProductId)
    }
  }, [initialSiteId, initialProductId])

  useEffect(() => {
    if (siteId && productId) {
      loadCurrentStock()
    } else {
      setCurrentStock(null)
    }
  }, [siteId, productId])

  const loadProducts = async () => {
    try {
      const data = await getProductsClient()
      setProducts(data)
    } catch (err) {
      console.error('Error loading products:', err)
    }
  }

  const loadCurrentStock = async () => {
    if (!siteId || !productId) return
    setLoadingStock(true)
    try {
      const stock = await getCurrentStock(siteId, productId)
      setCurrentStock(stock)
    } catch (err) {
      console.error('Error loading current stock:', err)
      setCurrentStock(null)
    } finally {
      setLoadingStock(false)
    }
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError('')
    setSuccess(false)

    const quantityValue = parseFloat(quantity)
    if (quantityValue <= 0) {
      setError('Quantity must be greater than 0')
      setLoading(false)
      return
    }

    // Validate stock availability
    if (currentStock !== null && quantityValue > currentStock) {
      setError(`Insufficient stock. Available: ${currentStock.toLocaleString()}, Requested: ${quantityValue.toLocaleString()}`)
      setLoading(false)
      return
    }

    try {
      const result = await registerOut(
        siteId,
        productId,
        parseFloat(quantity),
        notes || undefined
      )

      if (result.success) {
        setSuccess(true)
        setTimeout(() => {
          if (onClose) {
            onClose()
            router.refresh()
          } else {
            router.push('/inventory')
            router.refresh()
          }
        }, 1500)
      } else {
        setError(result.message || 'Failed to register consumption')
      }
    } catch (err: any) {
      setError(err.message || 'An error occurred')
    } finally {
      setLoading(false)
    }
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-5">
      <SiteSelector value={siteId} onChange={setSiteId} disabled={!!initialSiteId} />
      
      <Select
        label="Product"
        value={productId}
        onChange={(e) => setProductId(e.target.value)}
        required
        disabled={!!initialProductId}
      >
        <option value="">Select a product</option>
        {products.map((product) => (
          <option key={product.id} value={product.id}>
            {product.name} ({product.unit})
          </option>
        ))}
      </Select>

      <div>
        <Input
          label="Quantity"
          type="number"
          step="0.01"
          min="0.01"
          max={currentStock !== null ? currentStock : undefined}
          value={quantity}
          onChange={(e) => setQuantity(e.target.value)}
          placeholder="Enter quantity"
          required
        />
        {currentStock !== null && (
          <p className="mt-1.5 text-sm text-neutral-400">
            Available stock: <span className={`font-medium ${currentStock > 0 ? 'text-green-400' : 'text-red-400'}`}>
              {currentStock.toLocaleString()}
            </span>
          </p>
        )}
        {loadingStock && (
          <p className="mt-1.5 text-sm text-neutral-500">Loading stock...</p>
        )}
        {quantity && currentStock !== null && parseFloat(quantity) > currentStock && (
          <p className="mt-1.5 text-sm text-red-400">
            ⚠️ Quantity exceeds available stock
          </p>
        )}
      </div>

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
          Consumption registered successfully!{onClose ? '' : ' Redirecting...'}
        </div>
      )}

      <Button type="submit" disabled={loading || !siteId || !productId || !quantity} className="w-full">
        {loading ? 'Registering...' : 'Register Consumption (OUT)'}
      </Button>
    </form>
  )
}

'use client'
import { useState, useEffect } from 'react'
import { transferBetweenSites } from '@/lib/rpc/inventory'
import { getProductsClient, Product } from '@/lib/queries/products'
import { getCurrentStock } from '@/lib/queries/inventory'
import { getMasterSite, getSites } from '@/lib/queries/sites'
import Select from '@/components/ui/Select'
import Input from '@/components/ui/Input'
import Button from '@/components/ui/Button'
import { useRouter } from 'next/navigation'

interface TransferFormProps {
  initialToSiteId?: string
  initialProductId?: string
  onClose?: () => void
}

export default function TransferForm({ initialToSiteId = '', initialProductId = '', onClose }: TransferFormProps) {
  const [masterSiteId, setMasterSiteId] = useState<string>('')
  const [masterSiteName, setMasterSiteName] = useState<string>('Master Warehouse')
  const [toSiteId, setToSiteId] = useState(initialToSiteId)
  const [productId, setProductId] = useState(initialProductId)
  const [quantity, setQuantity] = useState('')
  const [notes, setNotes] = useState('')
  const [products, setProducts] = useState<Product[]>([])
  const [destinationSites, setDestinationSites] = useState<Array<{ id: string; name: string }>>([])
  const [currentStock, setCurrentStock] = useState<number | null>(null)
  const [loadingStock, setLoadingStock] = useState(false)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState(false)
  const router = useRouter()

  useEffect(() => {
    loadProducts()
    loadMasterAndSites()
    if (initialToSiteId) setToSiteId(initialToSiteId)
    if (initialProductId) setProductId(initialProductId)
  }, [initialToSiteId, initialProductId])

  useEffect(() => {
    if (masterSiteId && productId) {
      loadCurrentStock()
    } else {
      setCurrentStock(null)
    }
  }, [masterSiteId, productId])

  const loadProducts = async () => {
    try {
      const data = await getProductsClient()
      setProducts(data)
    } catch (err) {
      console.error('Error loading products:', err)
    }
  }

  const loadMasterAndSites = async () => {
    try {
      const [master, sites] = await Promise.all([getMasterSite(), getSites()])
      if (master?.id) {
        setMasterSiteId(master.id)
        setMasterSiteName(master.name || 'Master Warehouse')
      }
      setDestinationSites(sites.filter(s => !s.is_master).map(s => ({ id: s.id, name: s.name })))
    } catch (err) {
      console.error('Error loading sites:', err)
    }
  }

  const loadCurrentStock = async () => {
    if (!masterSiteId || !productId) return
    setLoadingStock(true)
    try {
      const stock = await getCurrentStock(masterSiteId, productId)
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

    if (!masterSiteId) {
      setError('Master warehouse not found')
      setLoading(false)
      return
    }

    const quantityValue = parseFloat(quantity)
    if (quantityValue <= 0) {
      setError('Quantity must be greater than 0')
      setLoading(false)
      return
    }

    // Validate stock availability at source site
    if (currentStock !== null && quantityValue > currentStock) {
      setError(`Insufficient stock at Master. Available: ${currentStock.toLocaleString()}, Requested: ${quantityValue.toLocaleString()}`)
      setLoading(false)
      return
    }

    try {
      const result = await transferBetweenSites(
        masterSiteId,
        toSiteId,
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
            router.push('/inventory/master')
            router.refresh()
          }
        }, 1500)
      } else {
        setError(result.message || 'Failed to send stock')
      }
    } catch (err: any) {
      setError(err.message || 'An error occurred')
    } finally {
      setLoading(false)
    }
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-5">
      <div className="bg-neutral-800/40 border border-neutral-700 rounded-lg px-4 py-3">
        <p className="text-sm text-neutral-400">
          <span className="text-neutral-500">From:</span>{' '}
          <span className="text-white font-medium">{masterSiteName}</span>{' '}
          <span className="text-xs text-neutral-500">(Master)</span>
        </p>
        <p className="text-xs text-neutral-500 mt-1">
          This action sends items from the Master Warehouse to a site (no site-to-site transfers).
        </p>
      </div>
      
      <Select
        label="To Site"
        value={toSiteId}
        onChange={(e) => setToSiteId(e.target.value)}
        required
      >
        <option value="">Select a site</option>
        {destinationSites.map((site) => (
          <option key={site.id} value={site.id}>
            {site.name}
          </option>
        ))}
      </Select>

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
            Available at Master: <span className={`font-medium ${currentStock > 0 ? 'text-green-400' : 'text-red-400'}`}>
              {currentStock.toLocaleString()}
            </span>
          </p>
        )}
        {loadingStock && (
          <p className="mt-1.5 text-sm text-neutral-500">Loading stock...</p>
        )}
        {quantity && currentStock !== null && parseFloat(quantity) > currentStock && (
          <p className="mt-1.5 text-sm text-red-400">
            ⚠️ Quantity exceeds available stock at source site
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
          Sent successfully!{onClose ? '' : ' Redirecting...'}
        </div>
      )}

      <Button type="submit" disabled={loading || !masterSiteId || !toSiteId || !productId || !quantity} className="w-full">
        {loading ? 'Sending...' : 'Send to Site'}
      </Button>
    </form>
  )
}

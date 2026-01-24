'use client'
import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import { getProductsClient, Product } from '@/lib/queries/products'
import { createDirectPurchase } from '@/lib/queries/direct-purchases.server'
import Select from '@/components/ui/Select'
import Input from '@/components/ui/Input'
import Button from '@/components/ui/Button'
import { useRouter } from 'next/navigation'

export default function DirectPurchaseForm() {
  const router = useRouter()
  const supabase = createClient()
  const [products, setProducts] = useState<Product[]>([])
  const [selectedProductId, setSelectedProductId] = useState('')
  const [quantity, setQuantity] = useState('')
  const [unitPrice, setUnitPrice] = useState('')
  const [notes, setNotes] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState(false)

  useEffect(() => {
    loadProducts()
  }, [])

  const loadProducts = async () => {
    try {
      const data = await getProductsClient()
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

    if (!selectedProductId) {
      setError('Please select a product')
      setLoading(false)
      return
    }

    const quantityNum = parseFloat(quantity)
    const priceNum = parseFloat(unitPrice)

    if (!quantityNum || quantityNum <= 0) {
      setError('Please enter a valid quantity')
      setLoading(false)
      return
    }

    if (!priceNum || priceNum < 0) {
      setError('Please enter a valid unit price')
      setLoading(false)
      return
    }

    try {
      // Note: createDirectPurchase is a server function, but we're calling it from client
      // We'll need to create an API route or RPC for this
      const response = await fetch('/api/purchases/direct', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          product_id: selectedProductId,
          quantity: quantityNum,
          unit_price: priceNum,
          notes: notes || null,
        }),
      })

      const result = await response.json()

      if (!response.ok || !result.success) {
        throw new Error(result.message || 'Failed to create direct purchase')
      }

      setSuccess(true)
      setTimeout(() => {
        router.push('/purchase-requests')
        router.refresh()
      }, 1500)
    } catch (err: any) {
      setError(err.message || 'An error occurred')
    } finally {
      setLoading(false)
    }
  }

  const selectedProduct = products.find(p => p.id === selectedProductId)
  const totalValue = selectedProductId && quantity && unitPrice
    ? parseFloat(quantity) * parseFloat(unitPrice)
    : 0

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      <div className="bg-blue-500/10 border border-blue-500/30 rounded-lg p-4 mb-4">
        <p className="text-sm text-blue-400">
          <strong>Direct Purchase:</strong> Purchase items directly and add them to the master warehouse. 
          These purchases will be included in monthly purchase reports.
        </p>
      </div>

      <Select
        label="Product"
        value={selectedProductId}
        onChange={(e) => {
          const productId = e.target.value
          setSelectedProductId(productId)
          const product = products.find(p => p.id === productId)
          if (product && product.price) {
            setUnitPrice(product.price.toString())
          }
        }}
        required
      >
        <option value="">Select a product</option>
        {products.map((product) => (
          <option key={product.id} value={product.id}>
            {product.name} ({product.unit}) - $ {(product.price || 0).toFixed(2)}
          </option>
        ))}
      </Select>

      <div className="grid grid-cols-2 gap-4">
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
          label="Unit Price ($)"
          type="number"
          step="0.01"
          min="0"
          value={unitPrice}
          onChange={(e) => setUnitPrice(e.target.value)}
          placeholder="0.00"
          required
        />
      </div>

      {totalValue > 0 && (
        <div className="bg-neutral-800 border border-neutral-700 rounded-lg p-4">
          <div className="flex justify-between items-center">
            <span className="text-neutral-400">Total Value:</span>
            <span className="text-xl font-bold text-green-400">
              $ {totalValue.toFixed(2)}
            </span>
          </div>
        </div>
      )}

      <Input
        label="Notes (optional)"
        type="text"
        value={notes}
        onChange={(e) => setNotes(e.target.value)}
        placeholder="Add notes for this purchase..."
      />

      {error && (
        <div className="bg-red-500/20 border border-red-500/30 text-red-400 px-4 py-3 rounded-lg text-sm">
          {error}
        </div>
      )}

      {success && (
        <div className="bg-green-500/20 border border-green-500/30 text-green-400 px-4 py-3 rounded-lg text-sm">
          Direct purchase created successfully! Items added to master warehouse. Redirecting...
        </div>
      )}

      <div className="flex space-x-4">
        <Button type="submit" disabled={loading || !selectedProductId || !quantity || !unitPrice}>
          {loading ? 'Creating...' : 'Create Direct Purchase'}
        </Button>
        <Button
          type="button"
          variant="secondary"
          onClick={() => router.push('/purchase-requests')}
        >
          Cancel
        </Button>
      </div>
    </form>
  )
}

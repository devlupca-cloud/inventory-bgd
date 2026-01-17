'use client'
import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import SiteSelector from '@/components/inventory/SiteSelector'
import { getProducts, Product } from '@/lib/queries/products'
import Select from '@/components/ui/Select'
import Input from '@/components/ui/Input'
import Button from '@/components/ui/Button'
import { useRouter } from 'next/navigation'

interface PurchaseRequestItem {
  product_id: string
  quantity_requested: number
  notes?: string
}

export default function PurchaseRequestForm() {
  const [siteId, setSiteId] = useState('')
  const [items, setItems] = useState<PurchaseRequestItem[]>([])
  const [products, setProducts] = useState<Product[]>([])
  const [notes, setNotes] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState(false)
  const router = useRouter()
  const supabase = createClient()

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

  const addItem = () => {
    setItems([...items, { product_id: '', quantity_requested: 0 }])
  }

  const removeItem = (index: number) => {
    setItems(items.filter((_, i) => i !== index))
  }

  const updateItem = (index: number, field: keyof PurchaseRequestItem, value: any) => {
    const newItems = [...items]
    newItems[index] = { ...newItems[index], [field]: value }
    setItems(newItems)
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError('')
    setSuccess(false)

    if (!siteId) {
      setError('Please select a site')
      setLoading(false)
      return
    }

    if (items.length === 0) {
      setError('Please add at least one item')
      setLoading(false)
      return
    }

    try {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) {
        setError('Not authenticated')
        setLoading(false)
        return
      }

      // Create purchase request (as draft)
      const { data: request, error: requestError } = await supabase
        .from('purchase_requests')
        .insert({
          site_id: siteId,
          status: 'draft',
          requested_by: user.id,
          notes: notes || null,
        })
        .select()
        .single()

      if (requestError) throw requestError

      // Create purchase request items
      const itemsToInsert = items.map(item => ({
        purchase_request_id: request.id,
        product_id: item.product_id,
        quantity_requested: item.quantity_requested,
        notes: item.notes || null,
      }))

      const { error: itemsError } = await supabase
        .from('purchase_request_items')
        .insert(itemsToInsert)

      if (itemsError) throw itemsError

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

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      <SiteSelector value={siteId} onChange={setSiteId} />

      <div>
        <div className="flex justify-between items-center mb-4">
          <h3 className="text-lg font-medium">Items</h3>
          <Button type="button" variant="secondary" onClick={addItem}>
            Add Item
          </Button>
        </div>

        <div className="space-y-4">
          {items.map((item, index) => (
            <div key={index} className="border rounded-lg p-4 space-y-3">
              <div className="flex justify-between items-start">
                <h4 className="font-medium">Item {index + 1}</h4>
                <Button
                  type="button"
                  variant="danger"
                  onClick={() => removeItem(index)}
                  className="text-xs py-1 px-2"
                >
                  Remove
                </Button>
              </div>

              <Select
                label="Product"
                value={item.product_id}
                onChange={(e) => updateItem(index, 'product_id', e.target.value)}
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
                label="Quantity Requested"
                type="number"
                step="0.01"
                min="0.01"
                value={item.quantity_requested || ''}
                onChange={(e) => updateItem(index, 'quantity_requested', parseFloat(e.target.value))}
                required
              />

              <Input
                label="Notes (optional)"
                type="text"
                value={item.notes || ''}
                onChange={(e) => updateItem(index, 'notes', e.target.value)}
              />
            </div>
          ))}
        </div>
      </div>

      <Input
        label="Request Notes (optional)"
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
          Purchase request created successfully! Redirecting...
        </div>
      )}

      <div className="flex space-x-4">
        <Button type="submit" disabled={loading || items.length === 0}>
          {loading ? 'Creating...' : 'Create Draft'}
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

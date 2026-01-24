'use client'
import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'
import { getProductsClient, Product } from '@/lib/queries/products'
import { getSites } from '@/lib/queries/sites'
import Select from '@/components/ui/Select'
import Input from '@/components/ui/Input'
import Button from '@/components/ui/Button'
import { useRouter } from 'next/navigation'

interface PurchaseRequestItem {
  product_id: string
  quantity_requested: number
  unit_price: number
  target_site_id?: string
  notes?: string
}

interface PurchaseRequestFormProps {}

export default function PurchaseRequestForm({}: PurchaseRequestFormProps) {
  const [items, setItems] = useState<PurchaseRequestItem[]>([])
  const [products, setProducts] = useState<Product[]>([])
  const [sites, setSites] = useState<Array<{ id: string; name: string; is_master: boolean }>>([])
  const [notes, setNotes] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState(false)
  const [userSiteId, setUserSiteId] = useState<string | null>(null)
  const [userRole, setUserRole] = useState<string | null>(null)
  const router = useRouter()
  const supabase = createClient()

  useEffect(() => {
    loadProducts()
    loadSites()
    loadUserSite()
  }, [])

  const loadUserSite = async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) return

      // Get user profile and role
      const { data: profile } = await supabase
        .from('user_profiles')
        .select('role')
        .eq('id', user.id)
        .single()
      
      if (profile) {
        setUserRole(profile.role)
        
        // If supervisor, get their site
        if (profile.role === 'supervisor') {
          const { data: siteRole } = await supabase
            .from('site_user_roles')
            .select('site_id')
            .eq('user_id', user.id)
            .single()
          
          if (siteRole) {
            setUserSiteId(siteRole.site_id)
          }
        }
      }
    } catch (err) {
      console.error('Error loading user site:', err)
    }
  }

  const loadSites = async () => {
    try {
      const data = await getSites()
      // Filter out master site from target options
      setSites(data.filter(site => !site.is_master).map(site => ({
        id: site.id,
        name: site.name,
        is_master: site.is_master
      })))
    } catch (err) {
      console.error('Error loading sites:', err)
    }
  }

  const loadProducts = async () => {
    try {
      const data = await getProductsClient()
      setProducts(data)
    } catch (err) {
      console.error('Error loading products:', err)
    }
  }


  const addItem = () => {
    // Auto-fill target_site_id with user's site if supervisor
    const defaultTargetSite = userRole === 'supervisor' && userSiteId ? userSiteId : ''
    setItems([...items, { product_id: '', quantity_requested: 0, unit_price: 0, target_site_id: defaultTargetSite }])
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

    // Requesting site is now optional - can create general purchase requests

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

      // Create purchase request (as draft) - no site_id needed
      // Items will be purchased and added to master warehouse, then distributed
      // User is tracked via requested_by, target sites are in items
      const { data: request, error: requestError } = await supabase
        .from('purchase_requests')
        // @ts-expect-error - Supabase type inference issue (site_id can be null)
        .insert({
          site_id: null, // No requesting site - user is tracked via requested_by
          status: 'draft',
          requested_by: user.id,
          notes: notes || null,
        })
        .select()
        .single()

      if (requestError) throw requestError
      if (!request) throw new Error('Failed to create purchase request')

      // Create purchase request items
      const itemsToInsert = items.map(item => ({
        purchase_request_id: (request as { id: string }).id,
        product_id: item.product_id,
        quantity_requested: item.quantity_requested,
        unit_price: item.unit_price || 0,
        target_site_id: item.target_site_id || null,
        notes: item.notes || null,
      }))

      const { error: itemsError } = await supabase
        .from('purchase_request_items')
        // @ts-expect-error - Supabase type inference issue
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
      <div className="bg-blue-500/10 border border-blue-500/30 rounded-lg p-4 mb-4">
        <p className="text-sm text-blue-400">
          <strong>Purchase Request:</strong> Create a request for items you need. 
          Items will be purchased and added to the master warehouse, then distributed to the target sites you specify for each item below.
        </p>
        {userRole === 'supervisor' && userSiteId && (
          <p className="text-xs text-green-400 mt-2">
            ✓ You are a supervisor. New items will be automatically set to your site ({sites.find(s => s.id === userSiteId)?.name || 'your site'}).
          </p>
        )}
        {userRole === 'manager' && (
          <p className="text-xs text-amber-400 mt-2">
            💡 You are a manager. You can create requests with items for multiple sites.
          </p>
        )}
      </div>

      <div>
        <div className="flex justify-between items-center mb-4">
          <h3 className="text-lg font-medium text-white">Items</h3>
          <Button type="button" variant="secondary" size="sm" onClick={addItem}>
            + Add Item
          </Button>
        </div>

        <div className="space-y-4">
          {items.length === 0 && (
            <div className="text-center py-8 border border-dashed border-neutral-700 rounded-lg">
              <p className="text-neutral-500 text-sm">No items added yet. Click "Add Item" to start.</p>
            </div>
          )}
          {items.map((item, index) => (
            <div key={index} className="border border-neutral-700 rounded-lg p-4 space-y-4 bg-neutral-800/50">
              <div className="flex justify-between items-start">
                <h4 className="font-medium text-neutral-300">Item {index + 1}</h4>
                <Button
                  type="button"
                  variant="ghost"
                  size="sm"
                  onClick={() => removeItem(index)}
                  className="text-red-400 hover:text-red-300 hover:bg-red-500/10"
                >
                  Remove
                </Button>
              </div>

              <Select
                label="Product"
                value={item.product_id || ''}
                onChange={(e) => {
                  const productId = e.target.value
                  const product = products.find(p => p.id === productId)
                  
                  // Update both fields in a single state update
                  const newItems = [...items]
                  newItems[index] = {
                    ...newItems[index],
                    product_id: productId,
                    unit_price: product ? (product.price || 0) : newItems[index].unit_price
                  }
                  setItems(newItems)
                }}
                required
              >
                <option value="">Select a product</option>
                {products.map((product) => (
                  <option key={product.id} value={product.id}>
                    {product.name} ({product.unit}) - R$ {(product.price || 0).toFixed(2)}
                  </option>
                ))}
              </Select>

              <div className="grid grid-cols-2 gap-4">
                <Input
                  label="Quantity Requested"
                  type="number"
                  step="0.01"
                  min="0.01"
                  value={item.quantity_requested || ''}
                  onChange={(e) => updateItem(index, 'quantity_requested', parseFloat(e.target.value))}
                  placeholder="Enter quantity"
                  required
                />

                <Input
                  label="Unit Price (R$)"
                  type="number"
                  step="0.01"
                  min="0"
                  value={item.unit_price || ''}
                  readOnly
                  className="bg-neutral-900/50 cursor-not-allowed"
                  placeholder="0.00"
                />
              </div>

              <Select
                label="Target Site (where this item should be distributed)"
                value={item.target_site_id || ''}
                onChange={(e) => updateItem(index, 'target_site_id', e.target.value || undefined)}
              >
                <option value="">Select target site (optional)</option>
                {sites.map((site) => (
                  <option key={site.id} value={site.id}>
                    {site.name}
                  </option>
                ))}
              </Select>
              {!item.target_site_id && (
                <p className="text-xs text-amber-400 mt-1">
                  ⚠️ No target site specified. This item will need manual distribution after purchase.
                </p>
              )}
              {item.target_site_id && (
                <p className="text-xs text-green-400 mt-1">
                  ✓ This item will be distributed to {sites.find(s => s.id === item.target_site_id)?.name || 'selected site'}
                </p>
              )}

              {item.quantity_requested > 0 && item.unit_price > 0 && (
                <div className="text-right text-sm">
                  <span className="text-neutral-400">Subtotal: </span>
                  <span className="text-green-400 font-medium">
                    R$ {(item.quantity_requested * item.unit_price).toFixed(2)}
                  </span>
                </div>
              )}

              <Input
                label="Notes (optional)"
                type="text"
                value={item.notes || ''}
                onChange={(e) => updateItem(index, 'notes', e.target.value)}
                placeholder="Add notes for this item..."
              />
            </div>
          ))}
        </div>
      </div>

      {items.length > 0 && (
        <div className="bg-neutral-800 border border-neutral-700 rounded-lg p-4">
          <div className="flex justify-between items-center">
            <span className="text-neutral-400">Total Estimated:</span>
            <span className="text-xl font-bold text-green-400">
              R$ {items.reduce((sum, item) => sum + (item.quantity_requested || 0) * (item.unit_price || 0), 0).toFixed(2)}
            </span>
          </div>
        </div>
      )}

      <Input
        label="Request Notes (optional)"
        type="text"
        value={notes}
        onChange={(e) => setNotes(e.target.value)}
        placeholder="Add general notes for this request..."
      />

      {error && (
        <div className="bg-red-500/20 border border-red-500/30 text-red-400 px-4 py-3 rounded-lg text-sm">
          {error}
        </div>
      )}

      {success && (
        <div className="bg-green-500/20 border border-green-500/30 text-green-400 px-4 py-3 rounded-lg text-sm">
          Purchase request created successfully! Redirecting...
        </div>
      )}

      <div className="flex space-x-4">
        <Button type="submit" disabled={loading || items.length === 0}>
          {loading ? 'Creating...' : 'Create Request'}
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

'use client'
import { useState, useEffect, useMemo, useRef } from 'react'
import { createClient } from '@/lib/supabase/client'
import { getProductsClient, Product } from '@/lib/queries/products'
import { getSites } from '@/lib/queries/sites'
import { PurchaseRequest, PurchaseRequestItem } from '@/lib/queries/purchase-requests'
import Select from '@/components/ui/Select'
import Input from '@/components/ui/Input'
import Button from '@/components/ui/Button'
import { useRouter } from 'next/navigation'

interface PurchaseRequestEditFormProps {
  request: PurchaseRequest
  items: PurchaseRequestItem[]
}

interface EditItem {
  id: string // existing item id
  product_id: string
  quantity_requested: number
  unit_price: number
  target_site_id?: string
  notes?: string
}

const REMOVED_NOTE_PREFIX = '__REMOVED__'

export default function PurchaseRequestEditForm({ request, items: initialItems }: PurchaseRequestEditFormProps) {
  const [items, setItems] = useState<EditItem[]>([])
  const [products, setProducts] = useState<Product[]>([])
  const [sites, setSites] = useState<Array<{ id: string; name: string; is_master: boolean }>>([])
  const [notes, setNotes] = useState(request.notes || '')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState(false)
  const [userSiteId, setUserSiteId] = useState<string | null>(null)
  const [userRole, setUserRole] = useState<string | null>(null)
  const router = useRouter()
  const supabase = createClient()
  const initialItemIdsRef = useRef<string[]>([])

  useEffect(() => {
    loadProducts()
    loadSites()
    loadUserSite()
    // Load existing items
    initialItemIdsRef.current = initialItems.map(i => i.id)
    setItems(initialItems.map(item => ({
      id: item.id,
      product_id: item.product_id,
      quantity_requested: item.quantity_requested,
      unit_price: item.unit_price || item.product.price || 0,
      target_site_id: item.target_site?.id || '',
      notes: item.notes || '',
    })))
  }, [])

  const removedItemIds = useMemo(() => {
    const initialIds = new Set(initialItemIdsRef.current.filter(Boolean))
    const currentIds = new Set(items.map(i => i.id).filter(Boolean))
    return [...initialIds].filter(id => !currentIds.has(id))
  }, [items])

  const loadUserSite = async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser()
      if (!user) return

      const { data: profile } = await supabase
        .from('user_profiles')
        .select('role')
        .eq('id', user.id)
        .single() as { data: { role: string } | null }
      
      if (profile) {
        setUserRole(profile.role)
        
        if (profile.role === 'supervisor') {
          const { data: siteRole } = await supabase
            .from('site_user_roles')
            .select('site_id')
            .eq('user_id', user.id)
            .single() as { data: { site_id: string } | null }
          
          if (siteRole) {
            setUserSiteId(siteRole.site_id)
          }
        }
      }
    } catch (err) {
      console.error('Error loading user site:', err)
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

  const loadSites = async () => {
    try {
      const data = await getSites()
      setSites(data.filter(site => !site.is_master).map(site => ({
        id: site.id,
        name: site.name,
        is_master: site.is_master
      })))
    } catch (err) {
      console.error('Error loading sites:', err)
    }
  }

  const addItem = () => {
    const defaultTargetSite = userRole === 'supervisor' && userSiteId ? userSiteId : ''
    setItems([...items, { 
      id: '', // empty id means new item
      product_id: '', 
      quantity_requested: 1, 
      unit_price: 0, 
      target_site_id: defaultTargetSite 
    }])
  }

  const updateItem = (index: number, field: keyof EditItem, value: any) => {
    const newItems = [...items]
    newItems[index] = { ...newItems[index], [field]: value }
    
    // Auto-fill unit price when product is selected
    if (field === 'product_id' && value) {
      const product = products.find(p => p.id === value)
      if (product && !newItems[index].unit_price) {
        newItems[index].unit_price = product.price
      }
    }
    
    setItems(newItems)
  }

  const removeItem = (index: number) => {
    setItems(items.filter((_, i) => i !== index))
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError('')
    setSuccess(false)

    if (items.length === 0) {
      setError('Please add at least one item')
      setLoading(false)
      return
    }

    // Validate items (quantity_requested must be > 0 due to DB constraint)
    for (let i = 0; i < items.length; i++) {
      const item = items[i]
      if (!item.product_id) {
        setError(`Item #${i + 1}: Please select a product`)
        setLoading(false)
        return
      }
      if (!item.quantity_requested || item.quantity_requested <= 0) {
        setError(`Item #${i + 1}: Quantity must be greater than 0`)
        setLoading(false)
        return
      }
    }

    try {
      // Update purchase request notes
      const { error: requestError } = await supabase
        .from('purchase_requests')
        // @ts-expect-error - Supabase type inference issue
        .update({ notes: notes || null })
        .eq('id', request.id)

      if (requestError) throw requestError

      // IMPORTANT:
      // Some setups with RLS will silently prevent DELETEs (0 rows deleted, no error).
      // If we "delete all then insert", this causes duplicates.
      // Instead we:
      // - UPDATE existing items (by id)
      // - INSERT only new items (id === '')
      // - DELETE only removed items (best-effort)

      const existingItems = items.filter(i => !!i.id)
      const newItems = items.filter(i => !i.id)

      // Update existing items
      for (const item of existingItems) {
        const { error: updateError } = await supabase
          .from('purchase_request_items')
          // @ts-expect-error - Supabase type inference issue
          .update({
            product_id: item.product_id,
            quantity_requested: item.quantity_requested,
            unit_price: item.unit_price || 0,
            target_site_id: item.target_site_id || null,
            notes: item.notes || null,
          })
          .eq('id', item.id)

        if (updateError) throw updateError
      }

      // Insert new items
      if (newItems.length > 0) {
        const itemsToInsert = newItems.map(item => ({
          purchase_request_id: request.id,
          product_id: item.product_id,
          quantity_requested: item.quantity_requested,
          unit_price: item.unit_price || 0,
          target_site_id: item.target_site_id || null,
          notes: item.notes || null,
        }))

        const { error: insertError } = await supabase
          .from('purchase_request_items')
          // @ts-expect-error - Supabase type inference issue
          .insert(itemsToInsert)

        if (insertError) throw insertError
      }

      // Delete removed items (best effort)
      if (removedItemIds.length > 0) {
        const { data: deletedRows, error: deleteRemovedError } = await supabase
          .from('purchase_request_items')
          .delete()
          .in('id', removedItemIds)
          .select('id')

        // If RLS blocks, this might delete 0 rows without error.
        // Still: the core issue (duplication) is solved because we no longer re-insert existing rows.
        if (deleteRemovedError) throw deleteRemovedError

        const deletedCount = (deletedRows || []).length
        if (deletedCount !== removedItemIds.length) {
          // Fallback for setups where DELETE is blocked by RLS (0 rows affected, no error).
          // We "hide" removed items by marking notes with a reserved prefix; UI/queries can filter them out.
          const { error: softRemoveError } = await supabase
            .from('purchase_request_items')
            // @ts-expect-error - Supabase type inference issue
            .update({ notes: `${REMOVED_NOTE_PREFIX} (no delete permission)` })
            .in('id', removedItemIds)

          if (softRemoveError) throw softRemoveError
        }
      }

      setSuccess(true)
      setTimeout(() => {
        router.push(`/purchase-requests/${request.id}`)
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
      {/* Info banner */}
      <div className="bg-blue-500/10 border border-blue-500/30 rounded-lg p-4">
        <p className="text-sm text-blue-400">
          <strong>Editing Draft Request:</strong> You can modify items, quantities, target sites, and notes. 
          Once you're done, you can submit it for approval.
        </p>
        {userRole === 'supervisor' && userSiteId && (
          <p className="text-xs text-green-400 mt-2">
            ✓ You are a supervisor. New items will be automatically set to your site ({sites.find(s => s.id === userSiteId)?.name || 'your site'}).
          </p>
        )}
        {userRole === 'manager' && (
          <p className="text-xs text-amber-400 mt-2">
            💡 You are a manager. You can set items for multiple sites.
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
          {items.map((item, index) => (
            <div key={index} className="bg-neutral-800/50 border border-neutral-700 rounded-lg p-4">
              <div className="grid grid-cols-1 md:grid-cols-6 gap-4">
                <div className="md:col-span-2">
                  <Select
                    label="Product"
                    value={item.product_id}
                    onChange={(e) => updateItem(index, 'product_id', e.target.value)}
                    required
                  >
                    <option value="">Select product</option>
                    {products.map(product => (
                      <option key={product.id} value={product.id}>
                        {product.name} ({product.unit})
                      </option>
                    ))}
                  </Select>
                </div>

                <div>
                  <Input
                    label="Quantity"
                    type="number"
                    step="0.01"
                    min="0.01"
                    value={item.quantity_requested || ''}
                    onChange={(e) => updateItem(index, 'quantity_requested', parseFloat(e.target.value))}
                    required
                  />
                </div>

                <div>
                  <Input
                    label="Unit Price ($)"
                    type="number"
                    step="0.01"
                    min="0"
                    value={item.unit_price || ''}
                    onChange={(e) => updateItem(index, 'unit_price', parseFloat(e.target.value))}
                    required
                  />
                </div>

                <div className="md:col-span-2">
                  <div className="relative">
                    <Select
                      label="Target Site → Where will this go?"
                      value={item.target_site_id || ''}
                      onChange={(e) => updateItem(index, 'target_site_id', e.target.value)}
                    >
                      <option value="">Select target site</option>
                      {sites.map(site => (
                        <option key={site.id} value={site.id}>
                          {site.name}
                        </option>
                      ))}
                    </Select>
                    {item.target_site_id && (
                      <div className="absolute right-2 top-8 text-green-400">
                        <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                          <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
                        </svg>
                      </div>
                    )}
                  </div>
                </div>
              </div>

              <div className="mt-3 flex justify-between items-end gap-4">
                <div className="flex-1">
                  <Input
                    label="Notes (optional)"
                    type="text"
                    placeholder="Any additional notes for this item..."
                    value={item.notes || ''}
                    onChange={(e) => updateItem(index, 'notes', e.target.value)}
                  />
                </div>
                <Button
                  type="button"
                  variant="secondary"
                  size="sm"
                  onClick={() => removeItem(index)}
                  className="border-red-500/30 text-red-400 hover:bg-red-500/10 mb-1"
                >
                  Remove
                </Button>
              </div>

              {item.target_site_id && (
                <div className="mt-2 text-xs text-blue-400 flex items-center">
                  <svg className="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 7l5 5m0 0l-5 5m5-5H6" />
                  </svg>
                  Target: {sites.find(s => s.id === item.target_site_id)?.name}
                </div>
              )}
            </div>
          ))}

          {items.length === 0 && (
            <div className="text-center py-8 bg-neutral-800/30 border border-neutral-700 rounded-lg">
              <p className="text-neutral-500">No items yet. Click "Add Item" to get started.</p>
            </div>
          )}
        </div>
      </div>

      <div>
        <label className="block text-sm font-medium text-neutral-300 mb-2">
          Notes (optional)
        </label>
        <textarea
          className="w-full px-4 py-2 bg-neutral-800 border border-neutral-700 rounded-lg text-white placeholder-neutral-500 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          rows={3}
          placeholder="Any additional notes for this purchase request..."
          value={notes}
          onChange={(e) => setNotes(e.target.value)}
        />
      </div>

      {error && (
        <div className="bg-red-500/20 border border-red-500/30 text-red-400 px-4 py-3 rounded-lg text-sm">
          {error}
        </div>
      )}

      {success && (
        <div className="bg-green-500/20 border border-green-500/30 text-green-400 px-4 py-3 rounded-lg text-sm">
          Purchase request updated successfully! Redirecting...
        </div>
      )}

      <div className="flex gap-4">
        <Button type="submit" disabled={loading || items.length === 0}>
          {loading ? 'Saving...' : 'Save Changes'}
        </Button>
        <Button
          type="button"
          variant="secondary"
          onClick={() => router.push(`/purchase-requests/${request.id}`)}
        >
          Cancel
        </Button>
      </div>
    </form>
  )
}

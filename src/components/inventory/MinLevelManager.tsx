'use client'
import { useState, useEffect } from 'react'
import { getSiteMinLevels, setMinLevel, deleteMinLevel, MinLevel } from '@/lib/queries/min-levels'
import { getProductsClient, Product } from '@/lib/queries/products'
import Input from '@/components/ui/Input'
import Button from '@/components/ui/Button'
import Select from '@/components/ui/Select'

interface MinLevelManagerProps {
  siteId: string
  canManage: boolean
}

export default function MinLevelManager({ siteId, canManage }: MinLevelManagerProps) {
  const [minLevels, setMinLevels] = useState<MinLevel[]>([])
  const [products, setProducts] = useState<Product[]>([])
  const [selectedProduct, setSelectedProduct] = useState('')
  const [newMinLevel, setNewMinLevel] = useState('')
  const [loading, setLoading] = useState(false)
  const [saving, setSaving] = useState<string | null>(null)
  const [editingValues, setEditingValues] = useState<Record<string, number>>({})
  const [error, setError] = useState('')
  const [success, setSuccess] = useState('')

  useEffect(() => {
    loadData()
  }, [siteId])

  const loadData = async () => {
    setLoading(true)
    try {
      const [levels, prods] = await Promise.all([
        getSiteMinLevels(siteId),
        getProductsClient(),
      ])
      setMinLevels(levels)
      setProducts(prods)
    } catch (err: any) {
      setError(err.message || 'Error loading data')
    } finally {
      setLoading(false)
    }
  }

  const handleAdd = async () => {
    if (!selectedProduct || !newMinLevel) {
      setError('Please select a product and enter a minimum level')
      return
    }

    const level = parseFloat(newMinLevel)
    if (isNaN(level) || level < 0) {
      setError('Minimum level must be a non-negative number')
      return
    }

    setSaving('add')
    setError('')
    setSuccess('')
    try {
      await setMinLevel(siteId, selectedProduct, level)
      await loadData()
      setSelectedProduct('')
      setNewMinLevel('')
      setSuccess('Minimum level added successfully')
      setTimeout(() => setSuccess(''), 3000)
    } catch (err: any) {
      setError(err.message || 'Error saving minimum level')
    } finally {
      setSaving(null)
    }
  }

  const handleUpdate = async (productId: string, level: number) => {
    setSaving(productId)
    setError('')
    setSuccess('')
    try {
      await setMinLevel(siteId, productId, level)
      await loadData()
      setSuccess('Minimum level updated successfully')
      setTimeout(() => setSuccess(''), 3000)
    } catch (err: any) {
      setError(err.message || 'Error updating minimum level')
    } finally {
      setSaving(null)
    }
  }

  const handleDelete = async (productId: string) => {
    if (!confirm('Are you sure you want to remove the minimum level for this product?')) {
      return
    }

    setSaving(productId)
    setError('')
    setSuccess('')
    try {
      await deleteMinLevel(siteId, productId)
      await loadData()
      setSuccess('Minimum level removed successfully')
      setTimeout(() => setSuccess(''), 3000)
    } catch (err: any) {
      setError(err.message || 'Error removing minimum level')
    } finally {
      setSaving(null)
    }
  }

  if (loading) {
    return (
      <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-6">
        <p className="text-neutral-500 text-center">Loading minimum levels...</p>
      </div>
    )
  }

  const productsWithLevels = minLevels.map(ml => ml.product_id)
  const availableProducts = products.filter(p => !productsWithLevels.includes(p.id))

  return (
    <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-6">
      <div className="flex items-center justify-between mb-6">
        <div>
          <h3 className="text-lg font-semibold text-white">Minimum Stock Levels</h3>
          <p className="text-sm text-neutral-400 mt-1">
            Configure minimum stock levels for each product at this site
          </p>
        </div>
      </div>

      {error && (
        <div className="bg-red-500/20 border border-red-500/30 text-red-400 px-4 py-3 rounded-lg text-sm mb-4">
          {error}
        </div>
      )}

      {success && (
        <div className="bg-green-500/20 border border-green-500/30 text-green-400 px-4 py-3 rounded-lg text-sm mb-4">
          {success}
        </div>
      )}

      {canManage && (
        <div className="mb-6 p-4 bg-neutral-800/50 rounded-lg border border-neutral-700">
          <h4 className="text-sm font-medium text-white mb-3">Add New Minimum Level</h4>
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
            <Select
              label="Product"
              value={selectedProduct}
              onChange={(e) => setSelectedProduct(e.target.value)}
            >
              <option value="">Select a product</option>
              {availableProducts.map((product) => (
                <option key={product.id} value={product.id}>
                  {product.name} ({product.unit})
                </option>
              ))}
            </Select>
            <Input
              label="Minimum Level"
              type="number"
              step="0.01"
              min="0"
              value={newMinLevel}
              onChange={(e) => setNewMinLevel(e.target.value)}
              placeholder="0.00"
            />
            <div className="flex items-end">
              <Button
                onClick={handleAdd}
                disabled={!selectedProduct || !newMinLevel || saving === 'add'}
                className="w-full"
                size="sm"
              >
                {saving === 'add' ? 'Adding...' : 'Add'}
              </Button>
            </div>
          </div>
        </div>
      )}

      {minLevels.length === 0 ? (
        <div className="text-center py-8 text-neutral-500">
          <p>No minimum levels configured yet.</p>
          {canManage && <p className="text-sm mt-2">Add a minimum level above to get started.</p>}
        </div>
      ) : (
        <div className="space-y-3">
          {minLevels.map((ml) => (
            <div
              key={`${ml.site_id}-${ml.product_id}`}
              className="flex items-center justify-between p-4 bg-neutral-800/50 rounded-lg border border-neutral-700"
            >
              <div className="flex-1">
                <p className="text-sm font-medium text-white">
                  {ml.product_name || 'Unknown Product'}
                </p>
                <p className="text-xs text-neutral-400 mt-1">
                  Unit: {ml.product_unit || 'N/A'}
                </p>
              </div>
              <div className="flex items-center space-x-3">
                {canManage ? (
                  <>
                    <div className="flex items-center space-x-2">
                      <Input
                        type="number"
                        step="0.01"
                        min="0"
                        value={editingValues[ml.product_id] !== undefined ? editingValues[ml.product_id] : ml.min_level}
                        onChange={(e) => {
                          const newLevel = parseFloat(e.target.value)
                          if (!isNaN(newLevel) && newLevel >= 0) {
                            setEditingValues(prev => ({
                              ...prev,
                              [ml.product_id]: newLevel
                            }))
                          }
                        }}
                        onBlur={() => {
                          const newLevel = editingValues[ml.product_id]
                          if (newLevel !== undefined && newLevel !== ml.min_level) {
                            handleUpdate(ml.product_id, newLevel)
                            setEditingValues(prev => {
                              const updated = { ...prev }
                              delete updated[ml.product_id]
                              return updated
                            })
                          }
                        }}
                        className="w-24"
                        disabled={saving === ml.product_id}
                      />
                      {saving === ml.product_id && (
                        <span className="text-xs text-neutral-500">Saving...</span>
                      )}
                    </div>
                    <Button
                      variant="ghost"
                      size="sm"
                      onClick={() => handleDelete(ml.product_id)}
                      disabled={saving === ml.product_id}
                      className="text-red-400 hover:text-red-300 hover:bg-red-500/10"
                    >
                      {saving === ml.product_id ? '...' : 'Remove'}
                    </Button>
                  </>
                ) : (
                  <span className="text-sm font-medium text-green-400">
                    {ml.min_level.toLocaleString()}
                  </span>
                )}
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}

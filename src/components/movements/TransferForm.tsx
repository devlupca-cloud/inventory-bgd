'use client'
import { useState, useEffect } from 'react'
import { transferBetweenSites } from '@/lib/rpc/inventory'
import { getSiteInventory, SiteInventoryItem } from '@/lib/queries/inventory'
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
  const [notes, setNotes] = useState('')
  const [destinationSites, setDestinationSites] = useState<Array<{ id: string; name: string }>>([])
  const [masterInventory, setMasterInventory] = useState<SiteInventoryItem[]>([])
  const [search, setSearch] = useState('')
  const [sendPlan, setSendPlan] = useState<Record<string, { quantity: number; unit: 'base' | 'package' } | undefined>>({})
  const [loadingInventory, setLoadingInventory] = useState(false)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState(false)
  const router = useRouter()

  useEffect(() => {
    loadMasterAndSites()
    if (initialToSiteId) setToSiteId(initialToSiteId)
    // initialProductId is ignored in the new UX (list-driven)
  }, [initialToSiteId, initialProductId])

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

  const loadMasterInventory = async (masterId: string) => {
    setLoadingInventory(true)
    try {
      const inv = await getSiteInventory(masterId)
      // Only show products that actually exist in Master
      setMasterInventory(inv.filter((row) => (row.quantity_on_hand || 0) > 0))
    } catch (err) {
      console.error('Error loading master inventory:', err)
      setMasterInventory([])
    } finally {
      setLoadingInventory(false)
    }
  }

  useEffect(() => {
    if (masterSiteId) {
      loadMasterInventory(masterSiteId)
    }
  }, [masterSiteId])

  const setQty = (productId: string, raw: string, max: number, unit: 'base' | 'package', unitsPerPackage: number) => {
    const parsed = raw === '' ? 0 : parseInt(raw, 10)
    const value = Number.isFinite(parsed) ? parsed : 0
    
    // Calculate max based on unit type
    const maxForUnit = unit === 'package' 
      ? Math.floor(max / unitsPerPackage)  // Max boxes available
      : max  // Max units available
    
    const clamped = Math.min(Math.max(0, value), maxForUnit)
    
    setSendPlan(prev => ({
      ...prev,
      [productId]: clamped > 0 ? { quantity: clamped, unit } : undefined,
    }))
  }
  
  const setUnit = (productId: string, unit: 'base' | 'package') => {
    setSendPlan(prev => {
      const current = prev[productId]
      if (!current) return prev
      
      // Convert quantity when switching units
      const product = masterInventory.find(r => r.product_id === productId)
      if (!product) return prev
      
      const unitsPerPackage = product.product.units_per_package || 1
      let newQuantity = current.quantity
      
      if (current.unit === 'package' && unit === 'base') {
        // Converting from boxes to units
        newQuantity = current.quantity * unitsPerPackage
      } else if (current.unit === 'base' && unit === 'package') {
        // Converting from units to boxes
        newQuantity = Math.floor(current.quantity / unitsPerPackage)
      }
      
      return {
        ...prev,
        [productId]: { quantity: newQuantity, unit },
      }
    })
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

    if (!toSiteId) {
      setError('Please select a destination site')
      setLoading(false)
      return
    }

    const transfers = Object.entries(sendPlan)
      .filter(([_, plan]) => !!plan && plan.quantity > 0)
      .map(([productId, plan]) => {
        const product = masterInventory.find(r => r.product_id === productId)
        const unitsPerPackage = product?.product.units_per_package || 1
        
        // Convert to base units (what's stored in inventory)
        const quantityInBaseUnits = plan!.unit === 'package'
          ? plan!.quantity * unitsPerPackage  // Convert boxes to units
          : plan!.quantity  // Already in units
        
        return { productId, quantity: quantityInBaseUnits, plan: plan! }
      })

    if (transfers.length === 0) {
      setError('Please enter quantities for at least one product')
      setLoading(false)
      return
    }

    try {
      // Validate against Master inventory (integer-only, in base units)
      const availability = new Map(masterInventory.map((row) => [row.product_id, Math.floor(row.quantity_on_hand || 0)]))
      for (const t of transfers) {
        const available = availability.get(t.productId) || 0
        if (!Number.isInteger(t.quantity) || t.quantity <= 0) {
          throw new Error('All quantities must be whole numbers greater than 0')
        }
        if (t.quantity > available) {
          const name = masterInventory.find(r => r.product_id === t.productId)?.product?.name || 'product'
          throw new Error(`Cannot send more than available for ${name}. Available: ${available} ${masterInventory.find(r => r.product_id === t.productId)?.product?.base_unit || 'units'}`)
        }
      }

      for (const t of transfers) {
        const product = masterInventory.find(r => r.product_id === t.productId)
        const unitLabel = t.plan.unit === 'package' 
          ? `${t.plan.quantity} ${product?.product.unit || 'box(es)'}`
          : `${t.plan.quantity} ${product?.product.base_unit || 'unit(s)'}`
        
        const result = await transferBetweenSites(
          masterSiteId,
          toSiteId,
          t.productId,
          t.quantity, // Always in base units
          // Tag as "master stock" so site monthly report can split origin
          `Master send: ${unitLabel}${notes ? ` - ${notes}` : ''}`
        )

        if (!result.success) {
          throw new Error(result.message || 'Failed to send items')
        }
      }

      setSuccess(true)
      setSendPlan({})
      setTimeout(() => {
        if (onClose) {
          onClose()
          router.refresh()
        } else {
          router.push('/inventory/master')
          router.refresh()
        }
      }, 1200)
    } catch (err: any) {
      setError(err.message || 'An error occurred')
    } finally {
      setLoading(false)
    }
  }

  const filteredInventory = masterInventory.filter((row) => {
    const q = search.trim().toLowerCase()
    if (!q) return true
    const name = row.product?.name?.toLowerCase() || ''
    const unit = row.product?.unit?.toLowerCase() || ''
    return name.includes(q) || unit.includes(q)
  })

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
      
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
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

        <Input
          label="Search products"
          type="text"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          placeholder="Type to filter..."
        />
      </div>

      <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-4">
        <div className="flex items-center justify-between mb-3">
          <h4 className="text-white font-medium">Available in Master</h4>
          <p className="text-xs text-neutral-500">
            {filteredInventory.length} products
          </p>
        </div>

        {loadingInventory ? (
          <div className="py-8 text-center text-sm text-neutral-500">Loading inventory...</div>
        ) : filteredInventory.length === 0 ? (
          <div className="py-8 text-center text-sm text-neutral-500">No products found.</div>
        ) : (
          <div className="space-y-3 max-h-80 overflow-y-auto pr-1">
            {filteredInventory.map((row) => {
              const product = row.product
              const unitsPerPackage = product.units_per_package || 1
              const packagesAvailable = row.quantity_packages || 0
              const looseUnitsAvailable = row.quantity_loose_units || 0
              const totalAvailable = Math.floor(row.quantity_on_hand || 0)
              
              const currentPlan = sendPlan[row.product_id]
              const currentQty = currentPlan?.quantity || 0
              const currentUnit = currentPlan?.unit || 'base'
              
              // Calculate max based on selected unit
              const maxQty = currentUnit === 'package' 
                ? packagesAvailable  // Max boxes available
                : totalAvailable  // Max units available
              
              return (
                <div key={row.product_id} className="border border-neutral-800 rounded-lg p-3">
                  <div className="flex items-start justify-between mb-2">
                    <div className="flex-1">
                      <p className="text-white font-medium">{product.name}</p>
                      <div className="text-xs text-neutral-400 mt-1 space-y-0.5">
                        <p>
                          Total: <span className="text-green-400 font-semibold">{totalAvailable.toLocaleString()}</span> {product.base_unit}
                        </p>
                        {unitsPerPackage > 1 && (
                          <div className="flex gap-3 mt-1">
                            {packagesAvailable > 0 && (
                              <span className="text-blue-400">
                                📦 {packagesAvailable} {product.unit}(s) fechada(s)
                              </span>
                            )}
                            {looseUnitsAvailable > 0 && (
                              <span className="text-amber-400">
                                🟡 {looseUnitsAvailable.toLocaleString()} {product.base_unit}(s) solta(s)
                              </span>
                            )}
                          </div>
                        )}
                      </div>
                    </div>
                  </div>
                  
                  <div className="flex items-center gap-2">
                    {/* Unit selector */}
                    {unitsPerPackage > 1 && (
                      <div className="flex gap-1 bg-neutral-800 rounded-lg p-1">
                        <button
                          type="button"
                          onClick={() => setUnit(row.product_id, 'base')}
                          className={`px-2 py-1 text-xs rounded transition-colors ${
                            currentUnit === 'base'
                              ? 'bg-green-500 text-white'
                              : 'text-neutral-400 hover:text-white'
                          }`}
                        >
                          {product.base_unit}
                        </button>
                        <button
                          type="button"
                          onClick={() => setUnit(row.product_id, 'package')}
                          className={`px-2 py-1 text-xs rounded transition-colors ${
                            currentUnit === 'package'
                              ? 'bg-green-500 text-white'
                              : 'text-neutral-400 hover:text-white'
                          }`}
                        >
                          {product.unit}
                        </button>
                      </div>
                    )}
                    
                    {/* Quantity input */}
                    <div className="flex-1">
                      <Input
                        type="number"
                        min="0"
                        step="1"
                        max={maxQty}
                        value={currentQty || ''}
                        onChange={(e) => setQty(row.product_id, e.target.value, totalAvailable, currentUnit, unitsPerPackage)}
                        placeholder="0"
                        disabled={!toSiteId || totalAvailable <= 0}
                      />
                    </div>
                    
                    {/* Unit label */}
                    <span className="text-xs text-neutral-500 w-16">
                      {currentUnit === 'package' ? product.unit : product.base_unit}
                    </span>
                  </div>
                </div>
              )
            })}
          </div>
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

      <Button type="submit" disabled={loading || !masterSiteId || !toSiteId} className="w-full">
        {loading ? 'Sending...' : 'Send Items'}
      </Button>
    </form>
  )
}

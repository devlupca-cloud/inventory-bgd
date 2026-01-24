'use client'
import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { DistributionItem } from '@/lib/queries/distribution.server'
import { FlexibleDistributionItem } from '@/lib/queries/distribution-flexible.server'
import { getSites } from '@/lib/queries/sites'
import { transferBetweenSites } from '@/lib/rpc/inventory'
import { createClient } from '@/lib/supabase/client'
import Button from '@/components/ui/Button'
import Input from '@/components/ui/Input'
import Select from '@/components/ui/Select'

interface DistributionFormProps {
  requestId: string
  items: DistributionItem[]
  flexibleItems?: FlexibleDistributionItem[]
}

interface DistributionPlan {
  [itemId: string]: {
    [siteId: string]: number | undefined // quantity to distribute to each site
  }
}

export default function DistributionForm({ requestId, items, flexibleItems }: DistributionFormProps) {
  const router = useRouter()
  const supabase = createClient()
  const [sites, setSites] = useState<Array<{ id: string; name: string }>>([])
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState('')
  const [distributionPlan, setDistributionPlan] = useState<DistributionPlan>({})
  const [masterSiteId, setMasterSiteId] = useState<string | null>(null)

  // Use flexible items if available, otherwise fall back to regular items
  const displayItems = flexibleItems && flexibleItems.length > 0 
    ? flexibleItems.map(flex => ({
        product_id: flex.product_id,
        product_name: flex.product_name,
        product_unit: flex.product_unit,
        purchase_request_item_id: flex.from_request?.purchase_request_item_id || `flex-${flex.product_id}`,
        quantity_available: flex.master_stock,
        target_site_id: flex.from_request?.target_site_id || null,
        target_site_name: flex.from_request?.target_site_name || null,
        from_request: flex.from_request,
        additional_stock: flex.additional_stock,
      }))
    : items

  useEffect(() => {
    loadSites()
    // Pre-fill distribution plan with target_site_id when available
    const initialPlan: DistributionPlan = {}
    displayItems.forEach((item: any) => {
      const itemId = item.purchase_request_item_id || `flex-${item.product_id}`
      // Hide items that have no integer availability
      const availableInt = Math.max(0, Math.floor(item.quantity_available || 0))
      if (item.target_site_id && availableInt > 0) {
        if (!initialPlan[itemId]) {
          initialPlan[itemId] = {}
        }
        // Pre-fill with available quantity for target site (from request if available, otherwise use master stock)
        const quantityToPreFill = item.from_request?.quantity_available || item.quantity_available
        // Distribution is integer-only
        initialPlan[itemId][item.target_site_id] = Math.floor(quantityToPreFill)
      }
    })
    if (Object.keys(initialPlan).length > 0) {
      setDistributionPlan(initialPlan)
    }
  }, [items, flexibleItems])

  const loadSites = async () => {
    try {
      const allSites = await getSites()
      // Filter out master site for distribution targets
      const regularSites = allSites.filter(site => !site.is_master).map(site => ({
        id: site.id,
        name: site.name,
      }))
      setSites(regularSites)
      
      // Find master site
      const master = allSites.find(site => site.is_master)
      if (master) {
        setMasterSiteId(master.id)
      }
    } catch (err) {
      console.error('Error loading sites:', err)
    }
  }

  const updateDistribution = (itemId: string, siteId: string, quantity: number) => {
    setDistributionPlan(prev => ({
      ...prev,
      [itemId]: {
        ...prev[itemId],
        [siteId]: quantity > 0 ? quantity : undefined,
      }
    }))
  }

  const getTotalDistributed = (itemId: string): number => {
    const itemPlan = distributionPlan[itemId] || {}
    return Object.values(itemPlan)
      .filter((qty): qty is number => qty !== undefined)
      .reduce((sum, qty) => sum + qty, 0)
  }

  const getItemId = (item: any): string => item.purchase_request_item_id || `flex-${item.product_id}`

  const getAvailableInt = (item: any): number => Math.max(0, Math.floor(item.quantity_available || 0))

  // Only show items that have something to distribute (integer availability > 0)
  const visibleItems = displayItems.filter((item: any) => getAvailableInt(item) > 0)

  const getMaxForSite = (item: any, siteId: string): number => {
    const itemId = getItemId(item)
    const available = getAvailableInt(item)
    const current = distributionPlan[itemId]?.[siteId] || 0
    const distributedTotal = getTotalDistributed(itemId)
    // Allow editing current value, but never let total exceed available
    const max = available - (distributedTotal - current)
    return Math.max(0, Math.floor(max))
  }

  const getRemaining = (item: DistributionItem | any): number => {
    const itemId = getItemId(item)
    const distributed = getTotalDistributed(itemId)
    return getAvailableInt(item) - distributed
  }

  const handleDistribute = async () => {
    if (!masterSiteId) {
      setError('Master warehouse not found')
      return
    }

    // Validate distribution plan
    const hasDistributions = Object.values(distributionPlan).some(plan => 
      Object.values(plan).some(qty => qty && qty > 0)
    )

    if (!hasDistributions) {
      setError('Please specify quantities to distribute')
      return
    }

    // Validate no item exceeds available quantity
    for (const item of visibleItems) {
      const itemId = getItemId(item)
      const distributed = getTotalDistributed(itemId)
      if (distributed > getAvailableInt(item)) {
        setError(`Cannot distribute more than available for ${item.product_name}`)
        return
      }
    }

    setLoading(true)
    setError('')
    setSuccess('')

    try {
      // Create transfers for each distribution
      const transfers = []
      for (const item of visibleItems) {
        const itemId = getItemId(item)
        const itemPlan = distributionPlan[itemId] || {}
        for (const [siteId, quantity] of Object.entries(itemPlan)) {
          if (quantity && quantity > 0) {
            transfers.push({
              fromSiteId: masterSiteId,
              toSiteId: siteId,
              productId: item.product_id,
              quantity: Math.floor(quantity),
              // Store full requestId so we can report "received from PR" later
              notes: `Distribution from PR:${requestId}`,
            })
          }
        }
      }

      // Execute all transfers
      for (const transfer of transfers) {
        const result = await transferBetweenSites(
          transfer.fromSiteId,
          transfer.toSiteId,
          transfer.productId,
          transfer.quantity,
          transfer.notes
        )
        if (!result.success) {
          throw new Error(result.message || 'Failed to transfer items')
        }
      }

      setSuccess(`Successfully distributed items to ${transfers.length} location(s)`)
      setTimeout(() => {
        router.push(`/purchase-requests/${requestId}`)
        router.refresh()
      }, 1500)
    } catch (err: any) {
      setError(err.message || 'An error occurred during distribution')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-6">
      <h3 className="text-lg font-semibold text-white mb-4">Items Available for Distribution</h3>
      {flexibleItems && flexibleItems.length > 0 && (
        <p className="text-sm text-neutral-400 mb-4">
          Showing all products available in Master Warehouse. You can distribute items from this request or use other stock.
        </p>
      )}
      
      {visibleItems.length === 0 ? (
        <div className="bg-neutral-800/30 border border-neutral-800 rounded-lg p-6 text-center text-neutral-500">
          No items available to distribute right now.
        </div>
      ) : (
      <div className="space-y-6">
        {visibleItems.map((item: any) => {
          const itemId = getItemId(item)
          const distributed = getTotalDistributed(itemId)
          const remaining = getRemaining(item)
          const hasAdditionalStock = item.additional_stock && item.additional_stock > 0
          
          return (
            <div key={itemId} className="border border-neutral-800 rounded-lg p-4">
              <div className="flex items-start justify-between mb-4">
                <div>
                  <h4 className="text-white font-medium">{item.product_name}</h4>
                  <p className="text-sm text-neutral-400 mt-1">
                    <span className="text-green-400 font-medium">Total in Master: {getAvailableInt(item).toLocaleString()}</span> {item.product_unit}
                    {item.from_request && (
                      <>
                        <span className="ml-2 text-blue-400">
                          (From Request: {Math.floor(item.from_request.quantity_available || 0).toLocaleString()})
                        </span>
                        {hasAdditionalStock && (
                          <span className="ml-2 text-amber-400">
                            (+ {Math.floor(item.additional_stock || 0).toLocaleString()} from other sources)
                          </span>
                        )}
                      </>
                    )}
                    {item.target_site_name && (
                      <span className="ml-2 text-blue-400">→ Target: {item.target_site_name}</span>
                    )}
                  </p>
                </div>
                <div className="text-right">
                  <p className="text-xs text-neutral-500">Distributing</p>
                  <p className="text-lg font-bold text-blue-400">{distributed.toLocaleString()}</p>
                  <p className="text-xs text-neutral-500">Available: {remaining.toLocaleString()}</p>
                </div>
              </div>

              <div className="space-y-3">
                {sites.map((site) => {
                  const currentQty = distributionPlan[itemId]?.[site.id] || 0
                  const maxForSite = getMaxForSite(item, site.id)
                  return (
                    <div key={site.id} className="flex items-center space-x-3">
                      <div className="flex-1">
                        <label className="text-sm text-neutral-400">{site.name}</label>
                      </div>
                      <div className="w-32">
                        <Input
                          type="number"
                          min="0"
                          max={maxForSite}
                          step="1"
                          value={currentQty || ''}
                          onChange={(e) => {
                            const raw = e.target.value
                            const parsed = raw === '' ? 0 : parseInt(raw, 10)
                            const value = Number.isFinite(parsed) ? parsed : 0
                            const clamped = Math.min(Math.max(0, value), maxForSite)
                            updateDistribution(itemId, site.id, clamped)
                          }}
                          placeholder="0"
                        />
                      </div>
                      <span className="text-sm text-neutral-500 w-12">{item.product_unit}</span>
                    </div>
                  )
                })}
              </div>
            </div>
          )
        })}
      </div>
      )}

      {error && (
        <div className="mt-6 bg-red-500/20 border border-red-500/30 text-red-400 px-4 py-3 rounded-lg text-sm">
          {error}
        </div>
      )}

      {success && (
        <div className="mt-6 bg-green-500/20 border border-green-500/30 text-green-400 px-4 py-3 rounded-lg text-sm">
          {success}
        </div>
      )}

      <div className="mt-6 flex space-x-4">
        <Button onClick={handleDistribute} disabled={loading || !masterSiteId}>
          {loading ? 'Distributing...' : 'Distribute Items'}
        </Button>
        <Button variant="secondary" onClick={() => router.back()} disabled={loading}>
          Cancel
        </Button>
      </div>
    </div>
  )
}

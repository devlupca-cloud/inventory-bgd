'use client'
import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import { DistributionItem } from '@/lib/queries/distribution.server'
import { getSites } from '@/lib/queries/sites'
import { transferBetweenSites } from '@/lib/rpc/inventory'
import { createClient } from '@/lib/supabase/client'
import Button from '@/components/ui/Button'
import Input from '@/components/ui/Input'
import Select from '@/components/ui/Select'

interface DistributionFormProps {
  requestId: string
  items: DistributionItem[]
}

interface DistributionPlan {
  [itemId: string]: {
    [siteId: string]: number | undefined // quantity to distribute to each site
  }
}

export default function DistributionForm({ requestId, items }: DistributionFormProps) {
  const router = useRouter()
  const supabase = createClient()
  const [sites, setSites] = useState<Array<{ id: string; name: string }>>([])
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState('')
  const [distributionPlan, setDistributionPlan] = useState<DistributionPlan>({})
  const [masterSiteId, setMasterSiteId] = useState<string | null>(null)

  useEffect(() => {
    loadSites()
  }, [])

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

  const getRemaining = (item: DistributionItem): number => {
    const distributed = getTotalDistributed(item.purchase_request_item_id)
    return item.quantity_available - distributed
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
    for (const item of items) {
      const remaining = getRemaining(item)
      if (remaining < 0) {
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
      for (const item of items) {
        const itemPlan = distributionPlan[item.purchase_request_item_id] || {}
        for (const [siteId, quantity] of Object.entries(itemPlan)) {
          if (quantity && quantity > 0) {
            transfers.push({
              fromSiteId: masterSiteId,
              toSiteId: siteId,
              productId: item.product_id,
              quantity,
              notes: `Distribution from purchase request ${requestId.substring(0, 8)}`,
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
      
      <div className="space-y-6">
        {items.map((item) => {
          const remaining = getRemaining(item)
          const distributed = getTotalDistributed(item.purchase_request_item_id)
          
          return (
            <div key={item.purchase_request_item_id} className="border border-neutral-800 rounded-lg p-4">
              <div className="flex items-start justify-between mb-4">
                <div>
                  <h4 className="text-white font-medium">{item.product_name}</h4>
                  <p className="text-sm text-neutral-400 mt-1">
                    Available: <span className="text-green-400 font-medium">{item.quantity_available.toLocaleString()}</span> {item.product_unit}
                    {item.site_name && (
                      <span className="ml-2">• Original site: {item.site_name}</span>
                    )}
                  </p>
                </div>
                <div className="text-right">
                  <p className="text-xs text-neutral-500">Distributing</p>
                  <p className="text-lg font-bold text-blue-400">{distributed.toLocaleString()}</p>
                  <p className="text-xs text-neutral-500">Remaining: {remaining.toLocaleString()}</p>
                </div>
              </div>

              <div className="space-y-3">
                {sites.map((site) => {
                  const currentQty = distributionPlan[item.purchase_request_item_id]?.[site.id] || 0
                  return (
                    <div key={site.id} className="flex items-center space-x-3">
                      <div className="flex-1">
                        <label className="text-sm text-neutral-400">{site.name}</label>
                      </div>
                      <div className="w-32">
                        <Input
                          type="number"
                          min="0"
                          max={remaining + currentQty}
                          step="0.01"
                          value={currentQty || ''}
                          onChange={(e) => {
                            const value = parseFloat(e.target.value) || 0
                            updateDistribution(item.purchase_request_item_id, site.id, value)
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

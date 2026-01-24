'use client'
import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'

interface DistributionTrackingItem {
  item_id: string
  product_name: string
  product_unit: string
  target_site_name: string | null
  quantity_requested: number
  value_requested: number
  quantity_distributed: number
  value_distributed: number
  unit_price: number
}

interface DistributionTrackingTableProps {
  requestId: string
  items: any[]
}

export default function DistributionTrackingTable({ requestId, items }: DistributionTrackingTableProps) {
  const [tracking, setTracking] = useState<DistributionTrackingItem[]>([])
  const [loading, setLoading] = useState(true)
  const supabase = createClient()

  useEffect(() => {
    loadTracking()
  }, [requestId])

  const loadTracking = async () => {
    try {
      setLoading(true)
      
      // Build tracking from items and their distributions
      const trackingData: DistributionTrackingItem[] = []

      for (const item of items) {
        const unitPrice = item.unit_price || item.product.price || 0
        const valueRequested = item.quantity_requested * unitPrice

        // Get distributions for this specific product to the target site
        let quantityDistributed = 0
        
        if (item.target_site_id) {
          const { data: movements } = await supabase
            .from('stock_movements')
            .select('quantity')
            .eq('movement_type', 'TRANSFER_IN')
            .eq('site_id', item.target_site_id)
            .eq('product_id', item.product_id)
            .or(`notes.ilike.%${requestId}%,notes.ilike.%Purchase from request%,notes.ilike.%Distribution from purchase request%`)
          
          if (movements && movements.length > 0) {
            quantityDistributed = movements.reduce((sum: number, m: any) => sum + m.quantity, 0)
          }
        }

        const valueDistributed = quantityDistributed * unitPrice

        trackingData.push({
          item_id: item.id,
          product_name: item.product.name,
          product_unit: item.product.unit,
          target_site_name: item.target_site?.name || null,
          quantity_requested: item.quantity_requested,
          value_requested: valueRequested,
          quantity_distributed: quantityDistributed,
          value_distributed: valueDistributed,
          unit_price: unitPrice,
        })
      }

      setTracking(trackingData)
    } catch (err) {
      console.error('Error loading distribution tracking:', err)
    } finally {
      setLoading(false)
    }
  }

  if (loading) {
    return (
      <div className="text-center py-8">
        <div className="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-blue-500"></div>
        <p className="text-sm text-neutral-500 mt-2">Loading tracking data...</p>
      </div>
    )
  }

  if (tracking.length === 0) {
    return (
      <div className="text-center py-8 text-neutral-500">
        <p className="text-sm">No distribution data available yet</p>
      </div>
    )
  }

  // Group by target site
  const groupedBySite = tracking.reduce((acc, item) => {
    const siteName = item.target_site_name || 'No site specified'
    if (!acc[siteName]) {
      acc[siteName] = []
    }
    acc[siteName].push(item)
    return acc
  }, {} as Record<string, DistributionTrackingItem[]>)

  return (
    <div className="space-y-6">
      {Object.entries(groupedBySite).map(([siteName, siteItems]) => {
        const totalRequested = siteItems.reduce((sum, item) => sum + item.value_requested, 0)
        const totalDistributed = siteItems.reduce((sum, item) => sum + item.value_distributed, 0)
        const totalQtyRequested = siteItems.reduce((sum, item) => sum + item.quantity_requested, 0)
        const totalQtyDistributed = siteItems.reduce((sum, item) => sum + item.quantity_distributed, 0)
        
        return (
          <div key={siteName} className="bg-neutral-800/30 rounded-lg border border-neutral-700 overflow-hidden">
            {/* Site Header */}
            <div className="px-4 py-3 bg-neutral-800/50 border-b border-neutral-700">
              <div className="flex justify-between items-center">
                <h4 className="font-semibold text-white">{siteName}</h4>
                <div className="flex gap-6 text-sm">
                  <div>
                    <span className="text-neutral-500">Requested: </span>
                    <span className="text-blue-400 font-medium">{totalQtyRequested} items</span>
                    <span className="text-neutral-600 mx-1">•</span>
                    <span className="text-blue-400 font-medium">R$ {totalRequested.toFixed(2)}</span>
                  </div>
                  <div>
                    <span className="text-neutral-500">Distributed: </span>
                    <span className={`font-medium ${totalQtyDistributed > 0 ? 'text-green-400' : 'text-neutral-500'}`}>
                      {totalQtyDistributed} items
                    </span>
                    <span className="text-neutral-600 mx-1">•</span>
                    <span className={`font-medium ${totalDistributed > 0 ? 'text-green-400' : 'text-neutral-500'}`}>
                      R$ {totalDistributed.toFixed(2)}
                    </span>
                  </div>
                </div>
              </div>
            </div>

            {/* Items Table */}
            <div className="overflow-x-auto">
              <table className="min-w-full">
                <thead>
                  <tr className="border-b border-neutral-700">
                    <th className="px-4 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Product</th>
                    <th className="px-4 py-2 text-right text-xs font-medium text-neutral-500 uppercase">Qty Requested</th>
                    <th className="px-4 py-2 text-right text-xs font-medium text-neutral-500 uppercase">Value Requested</th>
                    <th className="px-4 py-2 text-right text-xs font-medium text-neutral-500 uppercase">Qty Distributed</th>
                    <th className="px-4 py-2 text-right text-xs font-medium text-neutral-500 uppercase">Value Distributed</th>
                    <th className="px-4 py-2 text-center text-xs font-medium text-neutral-500 uppercase">Status</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-neutral-700">
                  {siteItems.map((item) => {
                    const fulfillmentPct = item.quantity_requested > 0 
                      ? (item.quantity_distributed / item.quantity_requested) * 100 
                      : 0
                    
                    return (
                      <tr key={item.item_id} className="hover:bg-neutral-800/20">
                        <td className="px-4 py-3">
                          <span className="text-sm text-white">{item.product_name}</span>
                          <span className="text-xs text-neutral-500 ml-1">({item.product_unit})</span>
                        </td>
                        <td className="px-4 py-3 text-right">
                          <span className="text-sm text-neutral-300">{item.quantity_requested.toLocaleString()}</span>
                        </td>
                        <td className="px-4 py-3 text-right">
                          <span className="text-sm text-blue-400">R$ {item.value_requested.toFixed(2)}</span>
                        </td>
                        <td className="px-4 py-3 text-right">
                          <span className={`text-sm font-medium ${item.quantity_distributed > 0 ? 'text-green-400' : 'text-neutral-500'}`}>
                            {item.quantity_distributed.toLocaleString()}
                          </span>
                        </td>
                        <td className="px-4 py-3 text-right">
                          <span className={`text-sm font-medium ${item.value_distributed > 0 ? 'text-green-400' : 'text-neutral-500'}`}>
                            R$ {item.value_distributed.toFixed(2)}
                          </span>
                        </td>
                        <td className="px-4 py-3 text-center">
                          {item.quantity_distributed === 0 ? (
                            <span className="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-neutral-700 text-neutral-400">
                              Pending
                            </span>
                          ) : fulfillmentPct >= 100 ? (
                            <span className="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-green-500/20 text-green-400">
                              Complete
                            </span>
                          ) : (
                            <span className="inline-flex items-center px-2 py-1 rounded text-xs font-medium bg-amber-500/20 text-amber-400">
                              {fulfillmentPct.toFixed(0)}%
                            </span>
                          )}
                        </td>
                      </tr>
                    )
                  })}
                </tbody>
              </table>
            </div>
          </div>
        )
      })}
    </div>
  )
}

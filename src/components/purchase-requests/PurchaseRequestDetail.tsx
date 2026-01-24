'use client'
import { PurchaseRequest, PurchaseRequestItem } from '@/lib/queries/purchase-requests'
import { approvePurchaseRequest, receivePurchaseRequest, ItemReceived } from '@/lib/rpc/purchase-requests'
import { createClient } from '@/lib/supabase/client'
import Badge from '@/components/ui/Badge'
import Button from '@/components/ui/Button'
import Input from '@/components/ui/Input'
import DistributionTrackingTable from './DistributionTrackingTable'
import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation'
import Link from 'next/link'

interface PurchaseRequestDetailProps {
  request: PurchaseRequest
  items: PurchaseRequestItem[]
  isManager: boolean
}

export default function PurchaseRequestDetail({
  request,
  items,
  isManager,
}: PurchaseRequestDetailProps) {
  const router = useRouter()
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState('')
  const [receivingMode, setReceivingMode] = useState(false)
  const [receivedItems, setReceivedItems] = useState<Record<string, { quantity: number; price?: number }>>({})

  const getStatusBadge = (status: PurchaseRequest['status']) => {
    const variants: Record<PurchaseRequest['status'], 'default' | 'success' | 'warning' | 'danger' | 'info'> = {
      draft: 'default',
      submitted: 'info',
      approved: 'success',
      rejected: 'danger',
      fulfilled: 'success',
      partially_fulfilled: 'warning',
    }
    return variants[status] || 'default'
  }


  const handleApprove = async () => {
    if (!confirm('Are you sure you want to approve this purchase request?')) return

    setLoading(true)
    setError('')
    setSuccess('')

    try {
      const result = await approvePurchaseRequest(request.id, false)
      if (result.success) {
        setSuccess(result.message || 'Purchase request approved successfully')
        setTimeout(() => {
          router.refresh()
        }, 1000)
      } else {
        setError(result.message || 'Failed to approve request')
      }
    } catch (err: any) {
      setError(err.message || 'An error occurred')
    } finally {
      setLoading(false)
    }
  }

  const handleSubmit = async () => {
    if (!confirm('Are you sure you want to submit this purchase request for approval? Once submitted, it cannot be edited.')) return

    setLoading(true)
    setError('')
    setSuccess('')

    try {
      const supabase = createClient()
      const { error: updateError } = await supabase
        .from('purchase_requests')
        // @ts-expect-error - Supabase type inference issue
        .update({ status: 'submitted' })
        .eq('id', request.id)

      if (updateError) throw updateError

      setSuccess('Purchase request submitted successfully! Waiting for manager approval.')
      setTimeout(() => {
        router.refresh()
      }, 1000)
    } catch (err: any) {
      setError(err.message || 'Failed to submit request')
    } finally {
      setLoading(false)
    }
  }

  const handleAutoFill = () => {
    const autoFilledItems: Record<string, { quantity: number; price?: number }> = {}
    items.forEach(item => {
      const remaining = item.quantity_requested - item.quantity_received
      if (remaining > 0) {
        autoFilledItems[item.id] = {
          quantity: remaining,
          price: item.unit_price || item.product.price || undefined,
        }
      }
    })
    setReceivedItems(autoFilledItems)
  }

  const handleReceive = async () => {
    setLoading(true)
    setError('')
    setSuccess('')

    const itemsToReceive: ItemReceived[] = Object.entries(receivedItems)
      .filter(([_, data]) => data.quantity > 0)
      .map(([itemId, data]) => ({
        item_id: itemId,
        quantity_received: data.quantity,
        unit_price: data.price || null,
      }))

    if (itemsToReceive.length === 0) {
      setError('Please enter quantities for at least one item')
      setLoading(false)
      return
    }

    try {
      const result = await receivePurchaseRequest(request.id, itemsToReceive)
      if (result.success) {
        setSuccess('Purchase registered successfully! Items have been added to inventory.')
        setReceivingMode(false)
        setReceivedItems({})
        setTimeout(() => {
          router.refresh()
        }, 1500)
      } else {
        setError(result.message || 'Failed to receive items')
      }
    } catch (err: any) {
      setError(err.message || 'An error occurred')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="bg-neutral-900 border border-neutral-800 rounded-xl overflow-hidden">
      {/* Header */}
      <div className="px-6 py-5 border-b border-neutral-800">
        <div className="flex justify-between items-start">
          <div>
            <h2 className="text-xl font-bold text-white">Purchase Request #{request.id.slice(0, 8)}</h2>
            <p className="text-sm text-neutral-500 mt-1">
              {request.site ? (
                <>Site: {request.site.name}</>
              ) : (
                <span className="italic text-neutral-600">General Request (no specific site)</span>
              )}
            </p>
            <p className="text-xs text-neutral-600 mt-1">
              {request.status === 'draft' && 'Draft - Not yet submitted'}
              {request.status === 'submitted' && 'Waiting for manager approval'}
              {request.status === 'approved' && 'Approved - Ready to purchase'}
              {request.status === 'rejected' && 'Rejected by manager'}
              {(request.status === 'fulfilled' || request.status === 'partially_fulfilled') && 'Purchase completed'}
            </p>
          </div>
          <Badge variant={getStatusBadge(request.status)}>
            {request.status.replace('_', ' ')}
          </Badge>
        </div>
      </div>

      {/* Details */}
      <div className="px-6 py-4 border-b border-neutral-800">
        <div className="grid grid-cols-2 gap-4 text-sm">
          <div>
            <span className="text-neutral-500">Requested By:</span>
            <span className="ml-2 text-white">
              {request.requested_by_user.full_name || request.requested_by_user.email}
            </span>
          </div>
          <div>
            <span className="text-neutral-500">Created:</span>
            <span className="ml-2 text-white">
              {new Date(request.created_at).toLocaleString()}
            </span>
          </div>
          {request.approved_by && (
            <div>
              <span className="text-neutral-500">Approved At:</span>
              <span className="ml-2 text-white">
                {request.approved_at ? new Date(request.approved_at).toLocaleString() : 'N/A'}
              </span>
            </div>
          )}
        </div>

        {request.notes && (
          <div className="mt-4">
            <span className="text-neutral-500 text-sm">Notes:</span>
            <p className="mt-1 text-white">{request.notes}</p>
          </div>
        )}
      </div>

      {/* Financial Summary */}
      {items.length > 0 && (
        <div className="px-6 py-4 border-b border-neutral-800 bg-neutral-800/30">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            <div>
              <p className="text-xs text-neutral-500 mb-1">Total Items</p>
              <p className="text-lg font-bold text-white">{items.length}</p>
            </div>
            <div>
              <p className="text-xs text-neutral-500 mb-1">Estimated Value</p>
              <p className="text-lg font-bold text-blue-400">
                $ {items.reduce((sum, item) => sum + (item.quantity_requested * (item.unit_price || item.product.price || 0)), 0).toFixed(2)}
              </p>
            </div>
            <div>
              <p className="text-xs text-neutral-500 mb-1">Total Spent</p>
              <p className="text-lg font-bold text-green-400">
                $ {items.reduce((sum, item) => sum + (item.quantity_received * (item.unit_price || item.product.price || 0)), 0).toFixed(2)}
              </p>
            </div>
            <div>
              <p className="text-xs text-neutral-500 mb-1">Items Purchased</p>
              <p className="text-lg font-bold text-amber-400">
                {items.reduce((sum, item) => sum + item.quantity_received, 0).toLocaleString()}
              </p>
            </div>
          </div>
        </div>
      )}

      {/* Items */}
      <div className="px-6 py-4">
        <h3 className="text-lg font-semibold text-white mb-4">Items Requested</h3>
        <div className="overflow-x-auto">
          <table className="min-w-full">
            <thead>
              <tr className="border-b border-neutral-700">
                <th className="px-4 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Product</th>
                <th className="px-4 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Target Site</th>
                <th className="px-4 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Requested</th>
                <th className="px-4 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Purchased</th>
                <th className="px-4 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Unit Price</th>
                <th className="px-4 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Total Value</th>
                {receivingMode && (
                  <>
                    <th className="px-4 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Qty Purchased</th>
                    <th className="px-4 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Purchase Price</th>
                  </>
                )}
              </tr>
            </thead>
            <tbody className="divide-y divide-neutral-800">
              {items.map((item) => {
                const unitPrice = item.unit_price || item.product.price || 0
                const estimatedTotal = item.quantity_requested * unitPrice
                const spentTotal = item.quantity_received * unitPrice
                
                return (
                <tr key={item.id} className={item.quantity_received > 0 ? 'bg-green-500/5' : ''}>
                  <td className="px-4 py-3 whitespace-nowrap">
                    <span className="text-sm text-white font-medium">{item.product.name}</span>
                    <span className="text-xs text-neutral-500 ml-1">({item.product.unit})</span>
                  </td>
                  <td className="px-4 py-3 whitespace-nowrap">
                    {item.target_site ? (
                      <span className="text-sm text-blue-400 font-medium">{item.target_site.name}</span>
                    ) : (
                      <span className="text-sm text-neutral-500 italic">Not specified</span>
                    )}
                  </td>
                  <td className="px-4 py-3 whitespace-nowrap">
                    <span className="text-sm text-neutral-300">{item.quantity_requested.toLocaleString()}</span>
                  </td>
                  <td className="px-4 py-3 whitespace-nowrap">
                    <span className={`text-sm font-medium ${item.quantity_received >= item.quantity_requested ? 'text-green-400' : item.quantity_received > 0 ? 'text-amber-400' : 'text-neutral-400'}`}>
                      {item.quantity_received.toLocaleString()}
                    </span>
                    {item.quantity_received < item.quantity_requested && item.quantity_received > 0 && (
                      <span className="text-xs text-neutral-500 ml-1">(partial)</span>
                    )}
                  </td>
                  <td className="px-4 py-3 whitespace-nowrap">
                    <span className="text-sm text-neutral-300">$ {unitPrice.toFixed(2)}</span>
                  </td>
                  <td className="px-4 py-3 whitespace-nowrap">
                    <div className="flex flex-col">
                      {spentTotal > 0 ? (
                        <>
                          <span className="text-sm font-medium text-green-400">$ {spentTotal.toFixed(2)}</span>
                          {estimatedTotal !== spentTotal && (
                            <span className="text-xs text-neutral-500">Est: $ {estimatedTotal.toFixed(2)}</span>
                          )}
                        </>
                      ) : (
                        <span className="text-sm text-neutral-400">$ {estimatedTotal.toFixed(2)}</span>
                      )}
                    </div>
                  </td>
                  {receivingMode && (
                    <>
                      <td className="px-4 py-3 whitespace-nowrap">
                        <Input
                          type="number"
                          step="0.01"
                          min="0"
                          max={item.quantity_requested - item.quantity_received}
                          value={receivedItems[item.id]?.quantity || ''}
                          onChange={(e) => setReceivedItems({
                            ...receivedItems,
                            [item.id]: {
                              ...receivedItems[item.id],
                              quantity: parseFloat(e.target.value) || 0,
                            },
                          })}
                          className="w-24"
                        />
                      </td>
                      <td className="px-4 py-3 whitespace-nowrap">
                        <Input
                          type="number"
                          step="0.01"
                          min="0"
                          value={receivedItems[item.id]?.price || ''}
                          onChange={(e) => setReceivedItems({
                            ...receivedItems,
                            [item.id]: {
                              ...receivedItems[item.id],
                              price: parseFloat(e.target.value) || undefined,
                            },
                          })}
                          className="w-24"
                          placeholder="$0.00"
                        />
                      </td>
                    </>
                  )}
                </tr>
              )})}
            </tbody>
          </table>
        </div>
      </div>

      {/* Messages */}
      {error && (
        <div className="mx-6 mb-4 bg-red-500/20 border border-red-500/30 text-red-400 px-4 py-3 rounded-lg text-sm">
          {error}
        </div>
      )}

      {success && (
        <div className="mx-6 mb-4 bg-green-500/20 border border-green-500/30 text-green-400 px-4 py-3 rounded-lg text-sm">
          {success}
        </div>
      )}

      {/* Distribution Tracking Section - only show if items have been purchased */}
      {items.some(item => item.quantity_received > 0) && (
        <div className="px-6 py-4 border-t border-neutral-800">
          <div className="mb-4">
            <h3 className="text-lg font-semibold text-white mb-2">Distribution Tracking</h3>
            <p className="text-sm text-neutral-500">Track what each site requested vs what they received</p>
          </div>
          <DistributionTrackingTable requestId={request.id} items={items} />
        </div>
      )}

      {/* Actions */}
      <div className="px-6 py-4 border-t border-neutral-800">
        {/* Submit button for draft requests (anyone who created it) */}
        {request.status === 'draft' && (
          <div className="space-y-3">
            <div className="flex gap-3">
              <Button onClick={handleSubmit} disabled={loading}>
                {loading ? 'Submitting...' : 'Submit for Approval'}
              </Button>
              <Link href={`/purchase-requests/${request.id}/edit`}>
                <Button variant="secondary">
                  <svg className="w-4 h-4 mr-2 inline" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                  </svg>
                  Edit Draft
                </Button>
              </Link>
            </div>
            <p className="text-xs text-neutral-500">
              Edit this draft or submit it to send for manager approval. Once submitted, you won't be able to edit it.
            </p>
          </div>
        )}

        {/* Manager actions */}
        {isManager && (
          <>
            {/* Show message if status is not submitted */}
            {request.status !== 'submitted' && request.status !== 'approved' && request.status !== 'draft' && (
              <div className="mb-4 text-sm text-neutral-500">
                This request is in "{request.status}" status. Only "submitted" requests can be approved.
              </div>
            )}
            {request.status === 'submitted' && (
            <div className="space-y-3">
              <Button onClick={handleApprove} disabled={loading}>
                {loading ? 'Approving...' : 'Approve for Purchase'}
              </Button>
              <p className="text-xs text-neutral-500">
                Approving allows you to purchase and register these items
              </p>
            </div>
          )}
          {request.status === 'approved' && !receivingMode && (
            <div className="space-y-2">
              <Button onClick={() => {
                setReceivingMode(true)
                // Auto-fill immediately when entering receiving mode
                setTimeout(() => handleAutoFill(), 100)
              }}>
                Register Purchase
              </Button>
              <p className="text-xs text-neutral-500">
                After purchasing, register the items here to add them to inventory
              </p>
            </div>
          )}
          {receivingMode && (
            <div className="space-y-3">
              <div className="flex items-center space-x-3">
                <Button onClick={handleReceive} disabled={loading}>
                  {loading ? 'Registering...' : 'Complete Purchase'}
                </Button>
                <Button variant="secondary" onClick={() => {
                  setReceivingMode(false)
                  setReceivedItems({})
                }}>
                  Cancel
                </Button>
                <div className="flex-1"></div>
                <Button 
                  variant="secondary" 
                  size="sm"
                  onClick={handleAutoFill}
                  className="border-blue-500/30 text-blue-400 hover:bg-blue-500/10"
                >
                  <svg className="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                  Fill with Requested
                </Button>
              </div>
              <p className="text-xs text-neutral-500">
                Values are pre-filled with requested quantities and prices. Adjust if needed before completing.
              </p>
            </div>
          )}
          {(request.status === 'fulfilled' || request.status === 'partially_fulfilled') && (
            <div className="space-y-2 mt-4 pt-4 border-t border-neutral-800">
              <Link href={`/purchase-requests/${request.id}/distribute`}>
                <Button variant="secondary" className="w-full">
                  <svg className="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
                  </svg>
                  Distribute Between Sites
                </Button>
              </Link>
              <p className="text-xs text-neutral-500">
                Distribute items from Master Warehouse to sites
              </p>
            </div>
          )}
          </>
        )}
      </div>
    </div>
  )
}

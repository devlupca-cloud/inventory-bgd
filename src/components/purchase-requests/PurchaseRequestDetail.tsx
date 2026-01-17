'use client'
import { PurchaseRequest, PurchaseRequestItem } from '@/lib/queries/purchase-requests'
import { approvePurchaseRequest, receivePurchaseRequest, ItemReceived } from '@/lib/rpc/purchase-requests'
import Badge from '@/components/ui/Badge'
import Button from '@/components/ui/Button'
import Input from '@/components/ui/Input'
import { useState } from 'react'
import { useRouter } from 'next/navigation'

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
      const result = await approvePurchaseRequest(request.id)
      if (result.success) {
        setSuccess('Purchase request approved successfully')
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
        setSuccess('Items received successfully')
        setReceivingMode(false)
        setReceivedItems({})
        setTimeout(() => {
          router.refresh()
        }, 1000)
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
            <h2 className="text-xl font-bold text-white">Request #{request.id.slice(0, 8)}</h2>
            <p className="text-sm text-neutral-500 mt-1">
              Site: {request.site.name}
            </p>
          </div>
          <Badge variant={getStatusBadge(request.status)}>
            {request.status}
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

      {/* Items */}
      <div className="px-6 py-4">
        <h3 className="text-lg font-semibold text-white mb-4">Items</h3>
        <div className="overflow-x-auto">
          <table className="min-w-full">
            <thead>
              <tr className="border-b border-neutral-700">
                <th className="px-4 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Product</th>
                <th className="px-4 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Requested</th>
                <th className="px-4 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Received</th>
                {receivingMode && (
                  <>
                    <th className="px-4 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Qty to Receive</th>
                    <th className="px-4 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Unit Price</th>
                  </>
                )}
              </tr>
            </thead>
            <tbody className="divide-y divide-neutral-800">
              {items.map((item) => (
                <tr key={item.id}>
                  <td className="px-4 py-3 whitespace-nowrap">
                    <span className="text-sm text-white">{item.product.name}</span>
                    <span className="text-xs text-neutral-500 ml-1">({item.product.unit})</span>
                  </td>
                  <td className="px-4 py-3 whitespace-nowrap">
                    <span className="text-sm text-neutral-300">{item.quantity_requested.toLocaleString()}</span>
                  </td>
                  <td className="px-4 py-3 whitespace-nowrap">
                    <span className={`text-sm font-medium ${item.quantity_received >= item.quantity_requested ? 'text-green-400' : 'text-neutral-400'}`}>
                      {item.quantity_received.toLocaleString()}
                    </span>
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
              ))}
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

      {/* Actions */}
      {isManager && (
        <div className="px-6 py-4 border-t border-neutral-800 flex space-x-4">
          {request.status === 'submitted' && (
            <Button onClick={handleApprove} disabled={loading}>
              {loading ? 'Approving...' : 'Approve Request'}
            </Button>
          )}
          {request.status === 'approved' && !receivingMode && (
            <Button onClick={() => setReceivingMode(true)}>
              Receive Items
            </Button>
          )}
          {receivingMode && (
            <>
              <Button onClick={handleReceive} disabled={loading}>
                {loading ? 'Receiving...' : 'Complete Receiving'}
              </Button>
              <Button variant="secondary" onClick={() => {
                setReceivingMode(false)
                setReceivedItems({})
              }}>
                Cancel
              </Button>
            </>
          )}
        </div>
      )}
    </div>
  )
}

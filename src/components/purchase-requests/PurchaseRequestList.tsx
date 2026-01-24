'use client'
import { PurchaseRequest } from '@/lib/queries/purchase-requests'
import Badge from '@/components/ui/Badge'
import Link from 'next/link'

interface PurchaseRequestListProps {
  requests: PurchaseRequest[]
}

export default function PurchaseRequestList({ requests }: PurchaseRequestListProps) {
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

  const getStatusLabel = (status: PurchaseRequest['status']) => {
    const labels: Record<PurchaseRequest['status'], string> = {
      draft: 'Draft',
      submitted: 'Awaiting Approval',
      approved: 'Approved - Ready to Purchase',
      rejected: 'Rejected',
      fulfilled: 'Completed',
      partially_fulfilled: 'Partially Completed',
    }
    return labels[status] || status
  }

  if (requests.length === 0) {
    return (
      <div className="text-center py-12 text-neutral-500">
        <svg className="w-12 h-12 mx-auto mb-4 text-neutral-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
        </svg>
        <p>No purchase requests found.</p>
      </div>
    )
  }

  return (
    <div className="overflow-x-auto">
      <table className="min-w-full">
        <thead>
          <tr className="border-b border-neutral-800">
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Target Sites
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Status
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Items
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Total Value
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Requested By
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Created
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Actions
            </th>
          </tr>
        </thead>
        <tbody className="divide-y divide-neutral-800">
          {requests.map((request) => (
            <tr key={request.id} className="hover:bg-neutral-800/50 transition-colors">
              <td className="px-6 py-4 whitespace-nowrap">
                <span className="text-sm text-neutral-500 italic">Multiple sites</span>
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <Badge variant={getStatusBadge(request.status)}>
                  {getStatusLabel(request.status)}
                </Badge>
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <span className="text-sm text-neutral-300">
                  {request.total_items || 0} item{(request.total_items || 0) !== 1 ? 's' : ''}
                </span>
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <div className="flex flex-col">
                  {request.total_value_spent && request.total_value_spent > 0 ? (
                    <>
                      <span className="text-sm font-medium text-green-400">
                        $ {request.total_value_spent.toFixed(2)}
                      </span>
                      {request.total_value_estimated && request.total_value_estimated !== request.total_value_spent && (
                        <span className="text-xs text-neutral-500">
                          Est: $ {request.total_value_estimated.toFixed(2)}
                        </span>
                      )}
                    </>
                  ) : (
                    <span className="text-sm text-neutral-400">
                      $ {request.total_value_estimated?.toFixed(2) || '0.00'}
                    </span>
                  )}
                </div>
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <span className="text-sm text-neutral-300">
                  {request.requested_by_user?.full_name || request.requested_by_user?.email || 'Unknown User'}
                </span>
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <span className="text-sm text-neutral-500">
                  {new Date(request.created_at).toLocaleDateString()}
                </span>
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <Link
                  href={`/purchase-requests/${request.id}`}
                  className="text-sm text-green-500 hover:text-green-400 transition-colors"
                >
                  View →
                </Link>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}

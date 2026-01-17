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

  if (requests.length === 0) {
    return (
      <div className="text-center py-8 text-gray-500">
        No purchase requests found.
      </div>
    )
  }

  return (
    <div className="overflow-x-auto">
      <table className="min-w-full divide-y divide-gray-200">
        <thead className="bg-gray-50">
          <tr>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Site
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Status
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Requested By
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Created
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Actions
            </th>
          </tr>
        </thead>
        <tbody className="bg-white divide-y divide-gray-200">
          {requests.map((request) => (
            <tr key={request.id} className="hover:bg-gray-50">
              <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                {request.site.name}
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <Badge variant={getStatusBadge(request.status)}>
                  {request.status}
                </Badge>
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                {request.requested_by_user.full_name || request.requested_by_user.email}
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                {new Date(request.created_at).toLocaleDateString()}
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-sm font-medium">
                <Link
                  href={`/purchase-requests/${request.id}`}
                  className="text-blue-600 hover:text-blue-900"
                >
                  View
                </Link>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}

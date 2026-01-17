import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getPurchaseRequest, getPurchaseRequestItems } from '@/lib/queries/purchase-requests'
import { approvePurchaseRequest, receivePurchaseRequest, ItemReceived } from '@/lib/rpc/purchase-requests'
import { notFound } from 'next/navigation'
import Link from 'next/link'
import Badge from '@/components/ui/Badge'
import Button from '@/components/ui/Button'
import { hasRole } from '@/lib/utils/permissions'
import PurchaseRequestDetail from '@/components/purchase-requests/PurchaseRequestDetail'

export default async function PurchaseRequestDetailPage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  return (
    <ProtectedRoute>
      <PurchaseRequestDetailContent params={params} />
    </ProtectedRoute>
  )
}

async function PurchaseRequestDetailContent({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  const request = await getPurchaseRequest(id)
  const items = await getPurchaseRequestItems(id)

  if (!request) {
    notFound()
  }

  const isManager = await hasRole(['manager', 'owner'])

  return (
    <div className="min-h-screen bg-gray-50">
      <nav className="bg-white shadow">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center space-x-4">
              <Link href="/purchase-requests" className="text-gray-500 hover:text-gray-700">
                ← Back to Purchase Requests
              </Link>
              <h1 className="text-xl font-semibold text-gray-900">Purchase Request Details</h1>
            </div>
          </div>
        </div>
      </nav>

      <main className="max-w-4xl mx-auto py-6 sm:px-6 lg:px-8">
        <div className="px-4 py-6 sm:px-0">
          <PurchaseRequestDetail
            request={request}
            items={items}
            isManager={isManager}
          />
        </div>
      </main>
    </div>
  )
}

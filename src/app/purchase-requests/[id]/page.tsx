import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getPurchaseRequest, getPurchaseRequestItems } from '@/lib/queries/purchase-requests.server'
import { notFound } from 'next/navigation'
import Link from 'next/link'
import { hasRole } from '@/lib/utils/permissions'
import PurchaseRequestDetail from '@/components/purchase-requests/PurchaseRequestDetail'
import PurchaseRequestHistory from '@/components/purchase-requests/PurchaseRequestHistory'

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
    <div className="min-h-screen bg-black">
      {/* Navigation */}
      <nav className="bg-neutral-900 border-b border-neutral-800 lg:ml-64">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center space-x-4">
              <Link href="/purchase-requests" className="flex items-center text-neutral-400 hover:text-white transition-colors">
                <svg className="w-5 h-5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                </svg>
                Back
              </Link>
              <div className="h-6 w-px bg-neutral-700"></div>
              <h1 className="text-xl font-bold text-white">Request Details</h1>
            </div>
          </div>
        </div>
      </nav>

      {/* Main Content */}
      <main className="lg:ml-64 max-w-4xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <PurchaseRequestDetail
          request={request}
          items={items}
          isManager={isManager}
        />
        
        <div className="mt-6">
          <PurchaseRequestHistory request={request} />
        </div>
      </main>
    </div>
  )
}

import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getPurchaseRequest } from '@/lib/queries/purchase-requests.server'
import { getDistributionItems } from '@/lib/queries/distribution.server'
import { getFlexibleDistributionItems } from '@/lib/queries/distribution-flexible.server'
import { notFound } from 'next/navigation'
import Link from 'next/link'
import { hasRole } from '@/lib/utils/permissions'
import DistributionForm from '@/components/purchase-requests/DistributionForm'

export default async function DistributePage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  return (
    <ProtectedRoute requiredRoles={['manager', 'owner']}>
      <DistributeContent params={params} />
    </ProtectedRoute>
  )
}

async function DistributeContent({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  const request = await getPurchaseRequest(id)
  
  if (!request) {
    notFound()
  }

  // Get flexible distribution items (includes master stock beyond just this request)
  const flexibleItems = await getFlexibleDistributionItems(id)
  
  // Also get traditional distribution items for backward compatibility
  const distributionItems = await getDistributionItems()
  const requestItems = distributionItems.filter(item => item.purchase_request_id === id)

  if (requestItems.length === 0) {
    return (
      <div className="min-h-screen bg-black">
        <nav className="bg-neutral-900 border-b border-neutral-800 lg:ml-64">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="flex justify-between h-16">
              <div className="flex items-center space-x-4">
                <Link href={`/purchase-requests/${id}`} className="flex items-center text-neutral-400 hover:text-white transition-colors">
                  <svg className="w-5 h-5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                  </svg>
                  Back
                </Link>
                <div className="h-6 w-px bg-neutral-700"></div>
                <h1 className="text-xl font-bold text-white">Distribute Items</h1>
              </div>
            </div>
          </div>
        </nav>

        <main className="lg:ml-64 max-w-4xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
          <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-12 text-center">
            <div className="w-16 h-16 bg-blue-500/20 rounded-full flex items-center justify-center mx-auto mb-4">
              <svg className="w-8 h-8 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
              </svg>
            </div>
            <h3 className="text-lg font-semibold text-white mb-2">No Items to Distribute</h3>
            <p className="text-neutral-500">All items from this purchase request have already been distributed.</p>
          </div>
        </main>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-black">
      <nav className="bg-neutral-900 border-b border-neutral-800 lg:ml-64">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center space-x-4">
              <Link href={`/purchase-requests/${id}`} className="flex items-center text-neutral-400 hover:text-white transition-colors">
                <svg className="w-5 h-5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                </svg>
                Back
              </Link>
              <div className="h-6 w-px bg-neutral-700"></div>
              <h1 className="text-xl font-bold text-white">Distribute Items</h1>
            </div>
          </div>
        </div>
      </nav>

      <main className="lg:ml-64 max-w-4xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-6 mb-6">
          <h2 className="text-lg font-semibold text-white mb-2">Purchase Request #{id.substring(0, 8)}</h2>
          <p className="text-sm text-neutral-400">
            Distribute items from Master Warehouse to sites. You can use items from this request or any other stock available in the master warehouse.
          </p>
        </div>

        <DistributionForm requestId={id} items={requestItems} flexibleItems={flexibleItems} />
      </main>
    </div>
  )
}

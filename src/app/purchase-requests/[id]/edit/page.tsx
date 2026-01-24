import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getPurchaseRequest, getPurchaseRequestItems } from '@/lib/queries/purchase-requests.server'
import { notFound, redirect } from 'next/navigation'
import Link from 'next/link'
import PurchaseRequestEditForm from '@/components/purchase-requests/PurchaseRequestEditForm'

export default async function EditPurchaseRequestPage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  return (
    <ProtectedRoute>
      <EditPurchaseRequestContent params={params} />
    </ProtectedRoute>
  )
}

async function EditPurchaseRequestContent({
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

  // Only draft requests can be edited
  if (request.status !== 'draft') {
    redirect(`/purchase-requests/${id}`)
  }

  return (
    <div className="min-h-screen bg-black">
      {/* Navigation */}
      <nav className="bg-neutral-900 border-b border-neutral-800 lg:ml-64">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center space-x-4">
              <Link href={`/purchase-requests/${id}`} className="flex items-center text-neutral-400 hover:text-white transition-colors">
                <svg className="w-5 h-5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                </svg>
                Back to Request
              </Link>
              <div className="h-6 w-px bg-neutral-700"></div>
              <h1 className="text-xl font-bold text-white">Edit Purchase Request</h1>
            </div>
          </div>
        </div>
      </nav>

      {/* Main Content */}
      <main className="lg:ml-64 max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-6">
          <PurchaseRequestEditForm request={request} items={items} />
        </div>
      </main>
    </div>
  )
}

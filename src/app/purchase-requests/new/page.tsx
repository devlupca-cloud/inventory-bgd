import ProtectedRoute from '@/components/auth/ProtectedRoute'
import PurchaseRequestForm from '@/components/purchase-requests/PurchaseRequestForm'
import Link from 'next/link'

export default async function NewPurchaseRequestPage({
  searchParams,
}: {
  searchParams: Promise<{ siteId?: string }>
}) {
  return (
    <ProtectedRoute>
      <NewPurchaseRequestContent searchParams={searchParams} />
    </ProtectedRoute>
  )
}

async function NewPurchaseRequestContent({
  searchParams,
}: {
  searchParams: Promise<{ siteId?: string }>
}) {
  const params = await searchParams
  const siteId = params.siteId || ''
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
              <h1 className="text-xl font-bold text-white">Create Purchase Request</h1>
            </div>
          </div>
        </div>
      </nav>

      {/* Main Content */}
      <main className="lg:ml-64 max-w-3xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-6">
          <PurchaseRequestForm initialSiteId={siteId} />
        </div>
      </main>
    </div>
  )
}

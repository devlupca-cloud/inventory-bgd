import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getPurchaseRequests } from '@/lib/queries/purchase-requests.server'
import PurchaseRequestList from '@/components/purchase-requests/PurchaseRequestList'
import Link from 'next/link'
import Button from '@/components/ui/Button'
import AppHeaderWrapper from '@/components/layout/AppHeader'

export default async function PurchaseRequestsPage() {
  return (
    <ProtectedRoute>
      <PurchaseRequestsContent />
    </ProtectedRoute>
  )
}

async function PurchaseRequestsContent() {
  let requests: Awaited<ReturnType<typeof getPurchaseRequests>> = []
  let error: string | null = null
  
  try {
    requests = await getPurchaseRequests()
  } catch (err: any) {
    error = err.message || 'Failed to load purchase requests'
    console.error('Error loading purchase requests:', err)
  }

  return (
    <div className="min-h-screen bg-black">
      <AppHeaderWrapper variant="simple" title="Purchase Requests" backHref="/" />

      {/* Main Content */}
      <main className="lg:ml-64 max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center mb-6">
          <div>
            <h2 className="text-lg font-semibold text-white">All Requests</h2>
            <p className="text-sm text-neutral-500">Manage purchase requests</p>
          </div>
          <Link href="/purchase-requests/new">
            <Button>+ New Request</Button>
          </Link>
        </div>
        {error ? (
          <div className="bg-neutral-900 border border-red-500/30 rounded-xl p-6">
            <div className="flex items-center space-x-3">
              <div className="w-10 h-10 bg-red-500/20 rounded-lg flex items-center justify-center">
                <svg className="w-5 h-5 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                </svg>
              </div>
              <div>
                <h3 className="text-sm font-medium text-red-400">Error loading purchase requests</h3>
                <p className="text-sm text-neutral-400 mt-1">{error}</p>
              </div>
            </div>
          </div>
        ) : (
          <div className="bg-neutral-900 border border-neutral-800 rounded-xl overflow-hidden">
            <PurchaseRequestList requests={requests} />
          </div>
        )}
      </main>
    </div>
  )
}

import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getPurchaseRequests } from '@/lib/queries/purchase-requests'
import PurchaseRequestList from '@/components/purchase-requests/PurchaseRequestList'
import Link from 'next/link'
import Button from '@/components/ui/Button'
import { canModifySite } from '@/lib/utils/permissions'

export default async function PurchaseRequestsPage() {
  return (
    <ProtectedRoute>
      <PurchaseRequestsContent />
    </ProtectedRoute>
  )
}

async function PurchaseRequestsContent() {
  const requests = await getPurchaseRequests()

  return (
    <div className="min-h-screen bg-gray-50">
      <nav className="bg-white shadow">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center space-x-4">
              <Link href="/inventory" className="text-gray-500 hover:text-gray-700">
                ← Back to Inventory
              </Link>
              <h1 className="text-xl font-semibold text-gray-900">Purchase Requests</h1>
            </div>
          </div>
        </div>
      </nav>

      <main className="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <div className="px-4 py-6 sm:px-0">
          <div className="mb-4 flex justify-between items-center">
            <h2 className="text-2xl font-bold text-gray-900">All Requests</h2>
            <Link href="/purchase-requests/new">
              <Button>Create New Request</Button>
            </Link>
          </div>
          <div className="bg-white shadow rounded-lg p-6">
            <PurchaseRequestList requests={requests} />
          </div>
        </div>
      </main>
    </div>
  )
}

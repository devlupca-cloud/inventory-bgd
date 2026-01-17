import ProtectedRoute from '@/components/auth/ProtectedRoute'
import PurchaseRequestForm from '@/components/purchase-requests/PurchaseRequestForm'
import Link from 'next/link'

export default async function NewPurchaseRequestPage() {
  return (
    <ProtectedRoute>
      <NewPurchaseRequestContent />
    </ProtectedRoute>
  )
}

async function NewPurchaseRequestContent() {
  return (
    <div className="min-h-screen bg-gray-50">
      <nav className="bg-white shadow">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center space-x-4">
              <Link href="/purchase-requests" className="text-gray-500 hover:text-gray-700">
                ← Back to Purchase Requests
              </Link>
              <h1 className="text-xl font-semibold text-gray-900">Create Purchase Request</h1>
            </div>
          </div>
        </div>
      </nav>

      <main className="max-w-4xl mx-auto py-6 sm:px-6 lg:px-8">
        <div className="px-4 py-6 sm:px-0">
          <div className="bg-white shadow rounded-lg p-6">
            <PurchaseRequestForm />
          </div>
        </div>
      </main>
    </div>
  )
}

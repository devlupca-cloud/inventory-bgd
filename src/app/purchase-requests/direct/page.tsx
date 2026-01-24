import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { hasRole } from '@/lib/utils/permissions'
import DirectPurchaseForm from '@/components/purchase-requests/DirectPurchaseForm'
import AppHeaderWrapper from '@/components/layout/AppHeader'

export default async function DirectPurchasePage() {
  return (
    <ProtectedRoute requiredRoles={['manager', 'owner']}>
      <DirectPurchaseContent />
    </ProtectedRoute>
  )
}

async function DirectPurchaseContent() {
  const isManager = await hasRole(['manager', 'owner'])

  if (!isManager) {
    return (
      <div className="min-h-screen bg-black">
        <AppHeaderWrapper variant="simple" title="Direct Purchase" backHref="/purchase-requests" />
        <main className="lg:ml-64 max-w-4xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
          <div className="bg-red-500/20 border border-red-500/30 text-red-400 px-4 py-3 rounded-lg">
            Only managers can create direct purchases.
          </div>
        </main>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-black">
      <AppHeaderWrapper variant="simple" title="Direct Purchase" backHref="/purchase-requests" />
      
      <main className="lg:ml-64 max-w-4xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <div className="mb-6">
          <h2 className="text-2xl font-bold text-white mb-2">Create Direct Purchase</h2>
          <p className="text-neutral-400">Purchase items directly and add them to the master warehouse</p>
        </div>

        <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-6">
          <DirectPurchaseForm />
        </div>
      </main>
    </div>
  )
}

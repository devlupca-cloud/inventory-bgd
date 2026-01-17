import ProtectedRoute from '@/components/auth/ProtectedRoute'
import RegisterInForm from '@/components/movements/RegisterInForm'
import Link from 'next/link'
import { hasRole } from '@/lib/utils/permissions'

export default async function RegisterInPage() {
  return (
    <ProtectedRoute requiredRoles={['manager', 'owner']}>
      <RegisterInContent />
    </ProtectedRoute>
  )
}

async function RegisterInContent() {
  const canAccess = await hasRole(['manager', 'owner'])

  if (!canAccess) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 mb-2">Access Denied</h1>
          <p className="text-gray-600">Only managers and owners can register stock IN.</p>
          <Link href="/inventory" className="text-blue-600 hover:text-blue-800 mt-4 inline-block">
            ← Back to Inventory
          </Link>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <nav className="bg-white shadow">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center space-x-4">
              <Link href="/inventory" className="text-gray-500 hover:text-gray-700">
                ← Back to Inventory
              </Link>
              <h1 className="text-xl font-semibold text-gray-900">Register Stock IN</h1>
            </div>
          </div>
        </div>
      </nav>

      <main className="max-w-3xl mx-auto py-6 sm:px-6 lg:px-8">
        <div className="px-4 py-6 sm:px-0">
          <div className="bg-white shadow rounded-lg p-6">
            <RegisterInForm />
          </div>
        </div>
      </main>
    </div>
  )
}

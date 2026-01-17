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
      <div className="min-h-screen bg-black flex items-center justify-center">
        <div className="text-center">
          <div className="w-16 h-16 bg-red-500/20 rounded-full flex items-center justify-center mx-auto mb-4">
            <svg className="w-8 h-8 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
            </svg>
          </div>
          <h1 className="text-2xl font-bold text-white mb-2">Access Denied</h1>
          <p className="text-neutral-400">Only managers and owners can register stock IN.</p>
          <Link href="/inventory" className="text-green-500 hover:text-green-400 mt-4 inline-block">
            ← Back to Inventory
          </Link>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-black">
      {/* Navigation */}
      <nav className="bg-neutral-900 border-b border-neutral-800">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center space-x-4">
              <Link href="/inventory" className="flex items-center text-neutral-400 hover:text-white transition-colors">
                <svg className="w-5 h-5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                </svg>
                Back
              </Link>
              <div className="h-6 w-px bg-neutral-700"></div>
              <h1 className="text-xl font-bold text-white">Register Stock IN</h1>
            </div>
          </div>
        </div>
      </nav>

      {/* Main Content */}
      <main className="max-w-2xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-6">
          <RegisterInForm />
        </div>
      </main>
    </div>
  )
}

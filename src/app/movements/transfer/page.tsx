import ProtectedRoute from '@/components/auth/ProtectedRoute'
import TransferForm from '@/components/movements/TransferForm'
import Link from 'next/link'

export default async function TransferPage() {
  return (
    <ProtectedRoute>
      <TransferContent />
    </ProtectedRoute>
  )
}

async function TransferContent() {
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
              <h1 className="text-xl font-bold text-white">Transfer Between Sites</h1>
            </div>
          </div>
        </div>
      </nav>

      {/* Main Content */}
      <main className="max-w-2xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-6">
          <TransferForm />
        </div>
      </main>
    </div>
  )
}

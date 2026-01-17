import { redirect } from 'next/navigation'
import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getSitesServer } from '@/lib/queries/sites'
import Link from 'next/link'
import { createServerSupabaseClient } from '@/lib/supabase/server'

export default async function InventoryPage() {
  return (
    <ProtectedRoute>
      <InventoryContent />
    </ProtectedRoute>
  )
}

async function InventoryContent() {
  const supabase = await createServerSupabaseClient()
  const { data: { user } } = await supabase.auth.getUser()
  const sites = await getSitesServer()

  return (
    <div className="min-h-screen bg-gray-50">
      <nav className="bg-white shadow">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center">
              <h1 className="text-xl font-semibold text-gray-900">BGD Inventory System</h1>
            </div>
            <div className="flex items-center space-x-4">
              <Link href="/alerts" className="text-gray-700 hover:text-gray-900">
                Low Stock Alerts
              </Link>
              <Link href="/purchase-requests" className="text-gray-700 hover:text-gray-900">
                Purchase Requests
              </Link>
              <Link href="/movements/in" className="text-gray-700 hover:text-gray-900">
                Register IN
              </Link>
              <Link href="/movements/out" className="text-gray-700 hover:text-gray-900">
                Register OUT
              </Link>
              <Link href="/movements/transfer" className="text-gray-700 hover:text-gray-900">
                Transfer
              </Link>
              {user && (
                <span className="text-sm text-gray-500">{user.email}</span>
              )}
            </div>
          </div>
        </div>
      </nav>

      <main className="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <div className="px-4 py-6 sm:px-0">
          <h2 className="text-2xl font-bold text-gray-900 mb-6">Sites</h2>
          
          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {sites.map((site) => (
              <Link
                key={site.id}
                href={`/inventory/${site.id}`}
                className="block bg-white overflow-hidden shadow rounded-lg hover:shadow-lg transition-shadow"
              >
                <div className="p-6">
                  <h3 className="text-lg font-medium text-gray-900">{site.name}</h3>
                  {site.address && (
                    <p className="mt-2 text-sm text-gray-500">{site.address}</p>
                  )}
                  <div className="mt-4">
                    <span className="text-sm text-blue-600 hover:text-blue-800">
                      View inventory →
                    </span>
                  </div>
                </div>
              </Link>
            ))}
          </div>
        </div>
      </main>
    </div>
  )
}

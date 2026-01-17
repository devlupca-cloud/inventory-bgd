import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getSites } from '@/lib/queries/sites.server'
import Link from 'next/link'
import { createServerSupabaseClient } from '@/lib/supabase/server'
import LogoutButton from '@/components/ui/LogoutButton'

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
  const sites = await getSites()

  return (
    <div className="min-h-screen bg-black">
      {/* Navigation */}
      <nav className="bg-neutral-900 border-b border-neutral-800">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center">
              <div className="w-8 h-8 bg-green-500 rounded-lg flex items-center justify-center mr-3">
                <svg className="w-5 h-5 text-black" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                </svg>
              </div>
              <h1 className="text-xl font-bold text-white">BGD Inventory</h1>
            </div>
            <div className="flex items-center space-x-1">
              <Link href="/sites" className="px-3 py-2 text-sm text-neutral-400 hover:text-white hover:bg-neutral-800 rounded-lg transition-colors">
                Sites
              </Link>
              <Link href="/products" className="px-3 py-2 text-sm text-neutral-400 hover:text-white hover:bg-neutral-800 rounded-lg transition-colors">
                Products
              </Link>
              <Link href="/alerts" className="px-3 py-2 text-sm text-neutral-400 hover:text-white hover:bg-neutral-800 rounded-lg transition-colors">
                Alerts
              </Link>
              <Link href="/purchase-requests" className="px-3 py-2 text-sm text-neutral-400 hover:text-white hover:bg-neutral-800 rounded-lg transition-colors">
                Requests
              </Link>
              <Link href="/movements/in" className="px-3 py-2 text-sm text-neutral-400 hover:text-white hover:bg-neutral-800 rounded-lg transition-colors">
                Stock IN
              </Link>
              <Link href="/movements/out" className="px-3 py-2 text-sm text-neutral-400 hover:text-white hover:bg-neutral-800 rounded-lg transition-colors">
                Stock OUT
              </Link>
              <Link href="/movements/transfer" className="px-3 py-2 text-sm text-neutral-400 hover:text-white hover:bg-neutral-800 rounded-lg transition-colors">
                Transfer
              </Link>
              {user && (
                <>
                  <span className="ml-4 px-3 py-1.5 text-xs text-neutral-500 bg-neutral-800 rounded-full">
                    {user.email}
                  </span>
                  <LogoutButton />
                </>
              )}
            </div>
          </div>
        </div>
      </nav>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center mb-8">
          <div>
            <h2 className="text-2xl font-bold text-white">Sites</h2>
            <p className="text-neutral-400 mt-1">Select a site to view inventory</p>
          </div>
        </div>
        
        <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {sites.map((site) => (
            <Link
              key={site.id}
              href={`/inventory/${site.id}`}
              className="group block bg-neutral-900 border border-neutral-800 rounded-xl p-6 hover:border-green-500/50 hover:bg-neutral-800/50 transition-all duration-200"
            >
              <div className="flex items-start justify-between">
                <div className="w-12 h-12 bg-green-500/20 rounded-xl flex items-center justify-center group-hover:bg-green-500/30 transition-colors">
                  <svg className="w-6 h-6 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                  </svg>
                </div>
                <svg className="w-5 h-5 text-neutral-600 group-hover:text-green-500 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                </svg>
              </div>
              <h3 className="text-lg font-semibold text-white mt-4">{site.name}</h3>
              {site.address && (
                <p className="mt-1 text-sm text-neutral-500">{site.address}</p>
              )}
            </Link>
          ))}
        </div>
      </main>
    </div>
  )
}

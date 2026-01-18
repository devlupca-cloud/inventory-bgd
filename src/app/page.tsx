import { redirect } from 'next/navigation'
import { createServerSupabaseClient } from '@/lib/supabase/server'
import { getDashboardData } from '@/lib/queries/dashboard.server'
import Link from 'next/link'
import AppHeaderWrapper from '@/components/layout/AppHeaderWrapper'
import QuickActions from '@/components/dashboard/QuickActions'

export default async function DashboardPage() {
  const supabase = await createServerSupabaseClient()
  const { data: { user } } = await supabase.auth.getUser()
  
  if (!user) {
    redirect('/login')
  }

  const dashboard = await getDashboardData()

  return (
    <div className="min-h-screen bg-black">
      <AppHeaderWrapper variant="full" sticky />

      <main className="lg:ml-64 max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
        {/* Quick Actions */}
        <section className="mb-8">
          <h2 className="text-lg font-semibold text-white mb-4">Quick Actions</h2>
          <QuickActions />
          <div className="mt-3">
            <Link
              href="/purchase-requests/new"
              className="inline-flex items-center justify-center p-4 bg-amber-500/10 border border-amber-500/30 rounded-xl hover:bg-amber-500/20 hover:border-amber-500/50 transition-all group"
            >
              <div className="w-12 h-12 bg-amber-500/20 rounded-xl flex items-center justify-center mr-3 group-hover:bg-amber-500/30 transition-colors">
                <svg className="w-6 h-6 text-amber-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                </svg>
              </div>
              <span className="text-sm font-medium text-amber-500">New Purchase Request</span>
            </Link>
          </div>
        </section>

        {/* Low Stock Alerts */}
        {dashboard.lowStockAlerts.length > 0 && (
          <section className="mb-8">
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center">
                <div className="w-2 h-2 bg-red-500 rounded-full animate-pulse mr-2"></div>
                <h2 className="text-lg font-semibold text-white">Low Stock Alerts</h2>
                <span className="ml-2 px-2 py-0.5 text-xs font-medium bg-red-500/20 text-red-400 rounded-full">
                  {dashboard.lowStockAlerts.length}
                </span>
              </div>
            </div>
            <div className="bg-neutral-900 border border-neutral-800 rounded-xl overflow-hidden">
              <div className="divide-y divide-neutral-800">
                {dashboard.lowStockAlerts
                  .filter((alert) => alert.site_id && alert.product_id)
                  .map((alert, index) => (
                  <div key={`alert-${alert.site_id || 'unknown'}-${alert.product_id || 'unknown'}-${index}`} className="p-4 flex items-center justify-between hover:bg-neutral-800/50 transition-colors">
                    <div className="flex items-center space-x-4">
                      <div className="w-10 h-10 bg-red-500/20 rounded-lg flex items-center justify-center">
                        <svg className="w-5 h-5 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                        </svg>
                      </div>
                      <div>
                        <p className="text-sm font-medium text-white">{alert.product_name}</p>
                        <p className="text-xs text-neutral-500">{alert.site_name}</p>
                      </div>
                    </div>
                    <div className="text-right">
                      <p className="text-sm font-bold text-red-400">{alert.quantity_on_hand} / {alert.min_level}</p>
                      <p className="text-xs text-neutral-500">Need {alert.shortage} more</p>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </section>
        )}

        {/* Pending Requests */}
        {dashboard.pendingRequests.length > 0 && (
          <section className="mb-8">
            <div className="flex items-center justify-between mb-4">
              <div className="flex items-center">
                <h2 className="text-lg font-semibold text-white">Pending Requests</h2>
                <span className="ml-2 px-2 py-0.5 text-xs font-medium bg-amber-500/20 text-amber-400 rounded-full">
                  {dashboard.pendingRequests.length}
                </span>
              </div>
              <Link href="/purchase-requests" className="text-sm text-green-500 hover:text-green-400 transition-colors">
                View all →
              </Link>
            </div>
            <div className="bg-neutral-900 border border-neutral-800 rounded-xl overflow-hidden">
              <div className="divide-y divide-neutral-800">
                {dashboard.pendingRequests.map((request) => (
                  <Link
                    key={request.id}
                    href={`/purchase-requests/${request.id}`}
                    className="p-4 flex items-center justify-between hover:bg-neutral-800/50 transition-colors block"
                  >
                    <div className="flex items-center space-x-4">
                      <div className={`w-10 h-10 rounded-lg flex items-center justify-center ${
                        request.status === 'submitted' ? 'bg-amber-500/20' : 'bg-green-500/20'
                      }`}>
                        <svg className={`w-5 h-5 ${request.status === 'submitted' ? 'text-amber-500' : 'text-green-500'}`} fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                        </svg>
                      </div>
                      <div>
                        <p className="text-sm font-medium text-white">{request.site_name}</p>
                        <p className="text-xs text-neutral-500">
                          by {request.requested_by_name || request.requested_by_email}
                        </p>
                      </div>
                    </div>
                    <div className="text-right">
                      <span className={`inline-block px-2 py-1 text-xs font-medium rounded-full ${
                        request.status === 'submitted' 
                          ? 'bg-amber-500/20 text-amber-400' 
                          : 'bg-green-500/20 text-green-400'
                      }`}>
                        {request.status}
                      </span>
                      <p className="text-xs text-neutral-500 mt-1">
                        {new Date(request.created_at).toLocaleDateString()}
                      </p>
                    </div>
                  </Link>
                ))}
              </div>
            </div>
          </section>
        )}

        {/* Sites Overview */}
        <section className="mb-8">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-white">Sites Overview</h2>
            <Link href="/inventory" className="text-sm text-green-500 hover:text-green-400 transition-colors">
              View inventory →
            </Link>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            {dashboard.siteSummaries.map((site) => (
              <Link
                key={site.id}
                href={`/inventory/${site.id}`}
                className="bg-neutral-900 border border-neutral-800 rounded-xl p-4 hover:border-green-500/50 hover:bg-neutral-800/50 transition-all group"
              >
                <div className="flex items-start justify-between mb-3">
                  <div className="w-10 h-10 bg-green-500/20 rounded-lg flex items-center justify-center group-hover:bg-green-500/30 transition-colors">
                    <svg className="w-5 h-5 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                    </svg>
                  </div>
                  {site.low_stock_count > 0 && (
                    <span className="px-2 py-1 text-xs font-medium bg-red-500/20 text-red-400 rounded-full">
                      {site.low_stock_count} low
                    </span>
                  )}
                </div>
                <h3 className="text-base font-semibold text-white">{site.name}</h3>
                {site.address && (
                  <p className="text-xs text-neutral-500 mt-1 truncate">{site.address}</p>
                )}
                <div className="flex items-center justify-between mt-3 pt-3 border-t border-neutral-800">
                  <span className="text-xs text-neutral-400">{site.total_products} products</span>
                  {site.last_movement && (
                    <span className="text-xs text-neutral-500">
                      Last: {new Date(site.last_movement).toLocaleDateString()}
                    </span>
                  )}
                </div>
              </Link>
            ))}
          </div>
        </section>

        {/* Recent Activity */}
        {dashboard.recentMovements.length > 0 && (
          <section className="mb-8">
            <h2 className="text-lg font-semibold text-white mb-4">Recent Activity</h2>
            <div className="bg-neutral-900 border border-neutral-800 rounded-xl overflow-hidden">
              <div className="divide-y divide-neutral-800">
                {dashboard.recentMovements.map((movement) => (
                  <div key={movement.id} className="p-4 flex items-center justify-between">
                    <div className="flex items-center space-x-4">
                      <div className={`w-10 h-10 rounded-lg flex items-center justify-center ${
                        movement.movement_type === 'IN' ? 'bg-green-500/20' :
                        movement.movement_type === 'OUT' ? 'bg-red-500/20' :
                        'bg-blue-500/20'
                      }`}>
                        {movement.movement_type === 'IN' && (
                          <svg className="w-5 h-5 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
                          </svg>
                        )}
                        {movement.movement_type === 'OUT' && (
                          <svg className="w-5 h-5 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 12H4" />
                          </svg>
                        )}
                        {(movement.movement_type === 'TRANSFER_IN' || movement.movement_type === 'TRANSFER_OUT') && (
                          <svg className="w-5 h-5 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
                          </svg>
                        )}
                      </div>
                      <div>
                        <p className="text-sm font-medium text-white">
                          {movement.product_name}
                          <span className={`ml-2 text-xs ${
                            movement.movement_type === 'IN' ? 'text-green-400' :
                            movement.movement_type === 'OUT' ? 'text-red-400' :
                            'text-blue-400'
                          }`}>
                            {movement.movement_type === 'IN' && `+${movement.quantity}`}
                            {movement.movement_type === 'OUT' && `-${movement.quantity}`}
                            {movement.movement_type === 'TRANSFER_IN' && `+${movement.quantity} (transfer)`}
                            {movement.movement_type === 'TRANSFER_OUT' && `-${movement.quantity} (transfer)`}
                          </span>
                        </p>
                        <p className="text-xs text-neutral-500">{movement.site_name}</p>
                      </div>
                    </div>
                    <div className="text-right">
                      <p className="text-xs text-neutral-400">
                        {new Date(movement.created_at).toLocaleDateString()}
                      </p>
                      <p className="text-xs text-neutral-500">
                        {new Date(movement.created_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                      </p>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </section>
        )}

        {/* Bottom Navigation for Mobile */}
        <nav className="fixed bottom-0 left-0 right-0 bg-neutral-900 border-t border-neutral-800 sm:hidden z-50">
          <div className="grid grid-cols-5 h-16">
            <Link href="/" className="flex flex-col items-center justify-center text-green-500">
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
              </svg>
              <span className="text-xs mt-1">Home</span>
            </Link>
            <Link href="/inventory" className="flex flex-col items-center justify-center text-neutral-400 hover:text-white">
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
              </svg>
              <span className="text-xs mt-1">Inventory</span>
            </Link>
            <Link href="/alerts" className="flex flex-col items-center justify-center text-neutral-400 hover:text-white relative">
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
              </svg>
              {dashboard.stats.totalAlerts > 0 && (
                <span className="absolute -top-1 -right-1 w-4 h-4 bg-red-500 text-white text-xs rounded-full flex items-center justify-center">
                  {dashboard.stats.totalAlerts}
                </span>
              )}
              <span className="text-xs mt-1">Alerts</span>
            </Link>
            <Link href="/purchase-requests" className="flex flex-col items-center justify-center text-neutral-400 hover:text-white">
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
              </svg>
              <span className="text-xs mt-1">Requests</span>
            </Link>
            <Link href="/sites" className="flex flex-col items-center justify-center text-neutral-400 hover:text-white">
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
              </svg>
              <span className="text-xs mt-1">Settings</span>
            </Link>
          </div>
        </nav>

        {/* Spacer for mobile bottom nav */}
        <div className="h-20 sm:hidden"></div>
      </main>
    </div>
  )
}

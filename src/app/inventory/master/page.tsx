import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getSiteInventoryServer } from '@/lib/queries/inventory.server'
import { getMasterSite } from '@/lib/queries/sites.server'
import InventoryTable from '@/components/inventory/InventoryTable'
import SiteQuickActions from '@/components/inventory/SiteQuickActions'
import { notFound } from 'next/navigation'
import Link from 'next/link'
import { hasRole } from '@/lib/utils/permissions'
import AppHeaderWrapper from '@/components/layout/AppHeaderWrapper'

export default async function MasterInventoryPage() {
  return (
    <ProtectedRoute requiredRoles={['manager', 'owner']}>
      <MasterInventoryContent />
    </ProtectedRoute>
  )
}

async function MasterInventoryContent() {
  const masterSite = await getMasterSite()
  const inventory = masterSite ? await getSiteInventoryServer(masterSite.id) : []
  const canManage = await hasRole(['manager', 'owner'])

  if (!masterSite) {
    notFound()
  }

  return (
    <div className="min-h-screen bg-black">
      <AppHeaderWrapper variant="simple" title="Master Warehouse" backHref="/" />

      {/* Main Content */}
      <main className="lg:ml-64 max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        {/* Master Info */}
        <div className="bg-gradient-to-r from-green-500/20 to-green-600/20 border border-green-500/30 rounded-xl p-6 mb-6">
          <div className="flex items-center justify-between">
            <div>
              <h2 className="text-2xl font-bold text-white mb-2">Master Warehouse</h2>
              <p className="text-neutral-300">
                Central inventory that supplies all sites. Purchased items are added here first, then transferred to sites as needed.
              </p>
            </div>
            <div className="w-16 h-16 bg-green-500/30 rounded-xl flex items-center justify-center">
              <svg className="w-8 h-8 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
              </svg>
            </div>
          </div>
        </div>

        {/* Summary Cards */}
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-6">
          <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-neutral-400">Total Products</p>
                <p className="text-2xl font-bold text-white mt-1">{inventory.length}</p>
              </div>
              <div className="w-12 h-12 bg-green-500/20 rounded-lg flex items-center justify-center">
                <svg className="w-6 h-6 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                </svg>
              </div>
            </div>
          </div>

          <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-neutral-400">Total Items</p>
                <p className="text-2xl font-bold text-white mt-1">
                  {inventory.reduce((sum, item) => sum + item.quantity_on_hand, 0).toLocaleString()}
                </p>
              </div>
              <div className="w-12 h-12 bg-blue-500/20 rounded-lg flex items-center justify-center">
                <svg className="w-6 h-6 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                </svg>
              </div>
            </div>
          </div>

          <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-neutral-400">Total Value</p>
                <p className="text-2xl font-bold text-green-400 mt-1">
                  $ {inventory.reduce((sum, item) => sum + ((item.product.price || 0) * item.quantity_on_hand), 0).toFixed(2)}
                </p>
              </div>
              <div className="w-12 h-12 bg-amber-500/20 rounded-lg flex items-center justify-center">
                <svg className="w-6 h-6 text-amber-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </div>
            </div>
          </div>
        </div>

        {/* Quick Actions */}
        <div className="mb-6">
          <h2 className="text-lg font-semibold text-white mb-4">Quick Actions</h2>
          <SiteQuickActions siteId={masterSite.id} canManage={canManage} canSupervise={canManage} />
        </div>

        {/* Inventory Table */}
        <div className="bg-neutral-900 border border-neutral-800 rounded-xl overflow-hidden">
          <div className="px-6 py-4 border-b border-neutral-800">
            <h2 className="text-lg font-semibold text-white">Master Inventory</h2>
            <p className="text-sm text-neutral-400 mt-1">All products in the central warehouse</p>
          </div>
          <InventoryTable items={inventory} />
        </div>
      </main>
    </div>
  )
}

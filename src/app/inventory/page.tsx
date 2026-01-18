import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getAllInventoryServer } from '@/lib/queries/inventory.server'
import { getProducts } from '@/lib/queries/products.server'
import { getSites } from '@/lib/queries/sites.server'
import Link from 'next/link'
import { hasRole } from '@/lib/utils/permissions'
import AppHeaderWrapper from '@/components/layout/AppHeader'
import SortableTable from '@/components/inventory/SortableTable'

export default async function InventoryPage() {
  return (
    <ProtectedRoute>
      <InventoryContent />
    </ProtectedRoute>
  )
}

async function InventoryContent() {
  const [inventory, products, sites] = await Promise.all([
    getAllInventoryServer(),
    getProducts(),
    getSites(false) // Exclude master from site filter
  ])
  const canManage = await hasRole(['manager', 'owner'])
  const canSupervise = await hasRole(['supervisor', 'manager', 'owner'])

  return (
    <div className="min-h-screen bg-black">
      <AppHeaderWrapper variant="full" />

      {/* Main Content */}
      <main className="lg:ml-64 max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center mb-8">
          <div>
            <h2 className="text-2xl font-bold text-white">Complete Inventory</h2>
            <p className="text-neutral-400 mt-1">All products across all sites</p>
          </div>
          {canManage && (
            <Link
              href="/inventory/master"
              className="px-4 py-2 bg-green-500/20 border border-green-500/30 text-green-400 rounded-lg hover:bg-green-500/30 transition-colors flex items-center space-x-2"
            >
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
              </svg>
              <span>Master Warehouse</span>
            </Link>
          )}
        </div>

        {inventory.length === 0 ? (
          <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-12 text-center">
            <div className="w-16 h-16 bg-neutral-800 rounded-full flex items-center justify-center mx-auto mb-4">
              <svg className="w-8 h-8 text-neutral-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
              </svg>
            </div>
            <h3 className="text-lg font-semibold text-white mb-2">No Inventory Yet</h3>
            <p className="text-neutral-500">Start by registering stock movements.</p>
          </div>
        ) : (
          <SortableTable 
            items={inventory} 
            canManage={canManage} 
            canSupervise={canSupervise}
            products={products.map(p => ({ id: p.id, name: p.name }))}
            sites={sites.map(s => ({ id: s.id, name: s.name }))}
          />
        )}
      </main>
    </div>
  )
}

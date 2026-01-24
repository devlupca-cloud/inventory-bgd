import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getSiteInventoryServer } from '@/lib/queries/inventory.server'
import { getSiteServer } from '@/lib/queries/sites.server'
import { getSiteStats } from '@/lib/queries/site-stats.server'
import InventoryTable from '@/components/inventory/InventoryTable'
import MinLevelManager from '@/components/inventory/MinLevelManager'
import SiteQuickActions from '@/components/inventory/SiteQuickActions'
import { notFound } from 'next/navigation'
import Link from 'next/link'
import { hasRole } from '@/lib/utils/permissions'
import AppHeaderWrapper from '@/components/layout/AppHeader'

export default async function SiteInventoryPage({
  params,
}: {
  params: Promise<{ siteId: string }>
}) {
  return (
    <ProtectedRoute>
      <SiteInventoryContent params={params} />
    </ProtectedRoute>
  )
}

async function SiteInventoryContent({
  params,
}: {
  params: Promise<{ siteId: string }>
}) {
  const { siteId } = await params
  const [site, inventory, stats] = await Promise.all([
    getSiteServer(siteId),
    getSiteInventoryServer(siteId),
    getSiteStats(siteId),
  ])
  const canManage = await hasRole(['manager', 'owner'])
  const canSupervise = await hasRole(['supervisor', 'manager', 'owner'])

  if (!site) {
    notFound()
  }

  return (
    <div className="min-h-screen bg-black">
      <AppHeaderWrapper variant="simple" title={site.name} backHref="/" />

      {/* Main Content */}
      <main className="lg:ml-64 max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        {/* Site Info & Quick Actions */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-6">
          {/* Site Information Card */}
          {(site.supervisor_name || site.supervisor_phone || site.address || canManage) && (
            <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-5">
              <div className="flex items-center justify-between mb-4">
                <div className="flex items-center">
                  <div className="w-10 h-10 bg-green-500/20 rounded-lg flex items-center justify-center mr-3">
                    <svg className="w-5 h-5 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                    </svg>
                  </div>
                  <h2 className="text-lg font-semibold text-white">Site Information</h2>
                </div>
                {canManage && !site.is_master && (
                  <Link
                    href={`/sites/${siteId}/edit`}
                    className="px-3 py-1.5 text-xs text-neutral-400 hover:text-white hover:bg-neutral-700 rounded-lg transition-colors"
                  >
                    Edit
                  </Link>
                )}
              </div>
              
              <div className="space-y-4">
                {site.address && (
                  <div>
                    <p className="text-xs text-neutral-500 mb-1">Address</p>
                    <p className="text-sm text-neutral-300">{site.address}</p>
                  </div>
                )}
                
                {(site.supervisor_name || site.supervisor_phone) && (
                  <div className="pt-3 border-t border-neutral-800">
                    <p className="text-xs text-neutral-500 mb-2">Supervisor</p>
                    {site.supervisor_name && (
                      <p className="text-sm font-medium text-white mb-2">{site.supervisor_name}</p>
                    )}
                    {site.supervisor_phone && (
                      <div className="space-y-2">
                        <p className="text-sm text-neutral-400">{site.supervisor_phone}</p>
                        <a
                          href={`https://wa.me/${site.supervisor_phone.replace(/[^0-9]/g, '')}`}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="inline-flex items-center justify-center px-4 py-2 text-sm font-medium text-white bg-green-500 hover:bg-green-600 rounded-lg transition-colors w-full"
                        >
                          <svg className="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 24 24">
                            <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413Z"/>
                          </svg>
                          Open WhatsApp
                        </a>
                      </div>
                    )}
                  </div>
                )}
              </div>
            </div>
          )}

          {/* Quick Actions */}
          <div className={`${(site.supervisor_name || site.supervisor_phone || site.address) ? 'lg:col-span-2' : 'lg:col-span-3'}`}>
            <h2 className="text-lg font-semibold text-white mb-4">Quick Actions</h2>
            <SiteQuickActions siteId={siteId} canManage={canManage} canSupervise={canSupervise} />
          </div>
        </div>

        {/* Summary Cards */}
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-6">
          <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-neutral-400">Total Gasto</p>
                <p className="text-2xl font-bold text-green-400 mt-1">
                  R$ {stats.totalSpent.toFixed(2)}
                </p>
                <p className="text-xs text-neutral-500 mt-1">em compras</p>
              </div>
              <div className="w-12 h-12 bg-green-500/20 rounded-lg flex items-center justify-center">
                <svg className="w-6 h-6 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </div>
            </div>
          </div>

          <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-neutral-400">Itens Comprados</p>
                <p className="text-2xl font-bold text-white mt-1">
                  {stats.totalItemsPurchased.toLocaleString()}
                </p>
                <p className="text-xs text-neutral-500 mt-1">quantidade total</p>
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
                <p className="text-sm text-neutral-400">Distribuições</p>
                <p className="text-2xl font-bold text-amber-400 mt-1">
                  {stats.totalDistributions}
                </p>
                <p className="text-xs text-neutral-500 mt-1">
                  {stats.lastPurchaseDate 
                    ? `última: ${new Date(stats.lastPurchaseDate).toLocaleDateString('pt-BR')}`
                    : 'nenhuma ainda'
                  }
                </p>
              </div>
              <div className="w-12 h-12 bg-amber-500/20 rounded-lg flex items-center justify-center">
                <svg className="w-6 h-6 text-amber-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
                </svg>
              </div>
            </div>
          </div>
        </div>

        {/* Inventory Table */}
        <div className="bg-neutral-900 border border-neutral-800 rounded-xl overflow-hidden mb-6">
          <div className="px-6 py-4 border-b border-neutral-800">
            <h2 className="text-lg font-semibold text-white">All Products</h2>
            <p className="text-sm text-neutral-400 mt-1">Complete inventory list for {site.name}</p>
          </div>
          <InventoryTable items={inventory} />
        </div>

        {/* Minimum Stock Levels Configuration */}
        <MinLevelManager siteId={siteId} canManage={canManage} />
      </main>
    </div>
  )
}

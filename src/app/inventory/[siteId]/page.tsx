import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getSiteInventory } from '@/lib/queries/inventory'
import { getSite } from '@/lib/queries/sites'
import InventoryTable from '@/components/inventory/InventoryTable'
import { notFound } from 'next/navigation'
import Link from 'next/link'

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
  const site = await getSite(siteId)
  const inventory = await getSiteInventory(siteId)

  if (!site) {
    notFound()
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
              <h1 className="text-xl font-bold text-white">{site.name}</h1>
            </div>
          </div>
        </div>
      </nav>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <div className="bg-neutral-900 border border-neutral-800 rounded-xl overflow-hidden">
          <div className="px-6 py-4 border-b border-neutral-800">
            <h2 className="text-lg font-semibold text-white">Inventory</h2>
            <p className="text-sm text-neutral-400 mt-1">Current stock levels for this site</p>
          </div>
          <InventoryTable items={inventory} />
        </div>
      </main>
    </div>
  )
}

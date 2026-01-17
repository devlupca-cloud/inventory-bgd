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
    <div className="min-h-screen bg-gray-50">
      <nav className="bg-white shadow">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center space-x-4">
              <Link href="/inventory" className="text-gray-500 hover:text-gray-700">
                ← Back to Sites
              </Link>
              <h1 className="text-xl font-semibold text-gray-900">{site.name}</h1>
            </div>
          </div>
        </div>
      </nav>

      <main className="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <div className="px-4 py-6 sm:px-0">
          <div className="bg-white shadow rounded-lg p-6">
            <h2 className="text-2xl font-bold text-gray-900 mb-4">Inventory</h2>
            <InventoryTable items={inventory} />
          </div>
        </div>
      </main>
    </div>
  )
}

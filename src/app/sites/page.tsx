import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getSites } from '@/lib/queries/sites.server'
import Link from 'next/link'
import Button from '@/components/ui/Button'
import { hasRole } from '@/lib/utils/permissions'
import SitesList from '@/components/sites/SitesList'
import AppHeaderWrapper from '@/components/layout/AppHeader'

export default async function SitesPage() {
  return (
    <ProtectedRoute>
      <SitesContent />
    </ProtectedRoute>
  )
}

async function SitesContent() {
  const sites = await getSites(true) // Include master site in the list
  const canManage = await hasRole(['manager', 'owner'])

  return (
    <div className="min-h-screen bg-black">
      <AppHeaderWrapper variant="simple" title="Manage Sites" backHref="/" />

      {/* Main Content */}
      <main className="lg:ml-64 max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center mb-6">
          <div>
            <h2 className="text-lg font-semibold text-white">All Sites</h2>
            <p className="text-sm text-neutral-500">{sites.length} site{sites.length !== 1 ? 's' : ''} registered</p>
          </div>
          {canManage && (
            <Link href="/sites/new">
              <Button>+ New Site</Button>
            </Link>
          )}
        </div>
        
        <SitesList sites={sites} canManage={canManage} />
      </main>
    </div>
  )
}

import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getSites } from '@/lib/queries/sites.server'
import Link from 'next/link'
import Button from '@/components/ui/Button'
import { hasRole } from '@/lib/utils/permissions'
import SitesList from '@/components/sites/SitesList'

export default async function SitesPage() {
  return (
    <ProtectedRoute>
      <SitesContent />
    </ProtectedRoute>
  )
}

async function SitesContent() {
  const sites = await getSites()
  const canManage = await hasRole(['manager', 'owner'])

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
              <h1 className="text-xl font-bold text-white">Manage Sites</h1>
            </div>
          </div>
        </div>
      </nav>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
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

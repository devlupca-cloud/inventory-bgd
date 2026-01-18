import ProtectedRoute from '@/components/auth/ProtectedRoute'
import SiteForm from '@/components/sites/SiteForm'
import { getSiteServer } from '@/lib/queries/sites.server'
import { notFound } from 'next/navigation'
import AppHeaderWrapper from '@/components/layout/AppHeader'

export default async function EditSitePage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  return (
    <ProtectedRoute requiredRoles={['manager', 'owner']}>
      <EditSiteContent params={params} />
    </ProtectedRoute>
  )
}

async function EditSiteContent({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  const site = await getSiteServer(id)

  if (!site) {
    notFound()
  }

  return (
    <div className="min-h-screen bg-black">
      <AppHeaderWrapper variant="simple" title="Edit Site" backHref={`/inventory/${id}`} />

      {/* Main Content */}
      <main className="max-w-2xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-6">
          <SiteForm site={site} />
        </div>
      </main>
    </div>
  )
}

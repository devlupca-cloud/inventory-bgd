'use client'
import { Site } from '@/lib/queries/sites'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/client'
import { useRouter } from 'next/navigation'
import { useState } from 'react'

interface SitesListProps {
  sites: Site[]
  canManage: boolean
}

export default function SitesList({ sites, canManage }: SitesListProps) {
  const [deleting, setDeleting] = useState<string | null>(null)
  const supabase = createClient()
  const router = useRouter()

  const handleDelete = async (siteId: string, siteName: string) => {
    if (!confirm(`Are you sure you want to delete "${siteName}"?`)) {
      return
    }

    setDeleting(siteId)
    try {
      // Soft delete - set deleted_at timestamp
      const { error } = await supabase
        .from('sites')
        .update({ deleted_at: new Date().toISOString() })
        .eq('id', siteId)

      if (error) throw error
      router.refresh()
    } catch (err: any) {
      alert(err.message || 'Failed to delete site')
    } finally {
      setDeleting(null)
    }
  }

  if (sites.length === 0) {
    return (
      <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-12 text-center">
        <div className="w-16 h-16 bg-neutral-800 rounded-full flex items-center justify-center mx-auto mb-4">
          <svg className="w-8 h-8 text-neutral-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
          </svg>
        </div>
        <h3 className="text-lg font-semibold text-white mb-2">No Sites Yet</h3>
        <p className="text-neutral-500 mb-4">Get started by creating your first site.</p>
        {canManage && (
          <Link href="/sites/new" className="text-green-500 hover:text-green-400 transition-colors">
            + Create Site
          </Link>
        )}
      </div>
    )
  }

  return (
    <div className="bg-neutral-900 border border-neutral-800 rounded-xl overflow-hidden">
      <table className="min-w-full">
        <thead>
          <tr className="border-b border-neutral-800">
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Name
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Address
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Created
            </th>
            {canManage && (
              <th className="px-6 py-3 text-right text-xs font-medium text-neutral-500 uppercase tracking-wider">
                Actions
              </th>
            )}
          </tr>
        </thead>
        <tbody className="divide-y divide-neutral-800">
          {sites.map((site) => (
            <tr key={site.id} className="hover:bg-neutral-800/50 transition-colors">
              <td className="px-6 py-4 whitespace-nowrap">
                <div className="flex items-center">
                  <div className="w-10 h-10 bg-green-500/20 rounded-lg flex items-center justify-center mr-3">
                    <svg className="w-5 h-5 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                    </svg>
                  </div>
                  <Link
                    href={`/inventory/${site.id}`}
                    className="text-sm font-medium text-white hover:text-green-400 transition-colors"
                  >
                    {site.name}
                  </Link>
                </div>
              </td>
              <td className="px-6 py-4">
                <span className="text-sm text-neutral-400">{site.address || '—'}</span>
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <span className="text-sm text-neutral-500">
                  {new Date(site.created_at).toLocaleDateString()}
                </span>
              </td>
              {canManage && (
                <td className="px-6 py-4 whitespace-nowrap text-right">
                  <button
                    onClick={() => handleDelete(site.id, site.name)}
                    disabled={deleting === site.id}
                    className="px-3 py-1.5 text-xs text-red-400 hover:text-red-300 hover:bg-red-500/10 rounded-lg transition-colors disabled:opacity-50"
                  >
                    {deleting === site.id ? 'Deleting...' : 'Delete'}
                  </button>
                </td>
              )}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}

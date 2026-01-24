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
  const [settingMaster, setSettingMaster] = useState<string | null>(null)
  const supabase = createClient()
  const router = useRouter()

  const handleSetMaster = async (siteId: string, siteName: string) => {
    if (!confirm(`Set "${siteName}" as the master warehouse? This will unset any other master site.`)) {
      return
    }

    setSettingMaster(siteId)
    try {
      // First, unset all other master sites
      const { error: unsetError } = await supabase
        .from('sites')
        // @ts-expect-error - Supabase type inference issue
        .update({ is_master: false })
        .eq('is_master', true)

      if (unsetError) throw unsetError

      // Then set this site as master
      const { error: setError } = await supabase
        .from('sites')
        // @ts-expect-error - Supabase type inference issue
        .update({ is_master: true })
        .eq('id', siteId)

      if (setError) throw setError
      router.refresh()
    } catch (err: any) {
      alert(err.message || 'Failed to set master site')
    } finally {
      setSettingMaster(null)
    }
  }

  const handleDelete = async (siteId: string, siteName: string, isMaster: boolean) => {
    if (isMaster) {
      alert('Master warehouse cannot be deleted')
      return
    }

    if (!confirm(`Are you sure you want to delete "${siteName}"? This action cannot be undone.`)) {
      return
    }

    setDeleting(siteId)
    try {
      // Use RPC function for soft delete
      const { data, error } = await supabase.rpc('rpc_delete_site', {
        p_site_id: siteId
      })

      if (error) {
        console.error('Delete error:', error)
        throw new Error(error.message || `Failed to delete site: ${error.code || 'Unknown error'}`)
      }

      if (!data || !data.success) {
        throw new Error(data?.message || 'Failed to delete site')
      }

      // Success - refresh the page
      router.refresh()
    } catch (err: any) {
      console.error('Delete site error:', err)
      alert(err.message || 'Failed to delete site. Please check the console for details.')
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
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Type
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
                  <div>
                    <Link
                      href={site.is_master ? '/inventory/master' : `/inventory/${site.id}`}
                      className="text-sm font-medium text-white hover:text-green-400 transition-colors"
                    >
                      {site.name}
                    </Link>
                    {site.is_master && (
                      <span className="ml-2 px-2 py-0.5 text-xs font-medium bg-amber-500/20 text-amber-400 rounded-full">
                        Master
                      </span>
                    )}
                  </div>
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
              <td className="px-6 py-4 whitespace-nowrap">
                {site.is_master ? (
                  <span className="px-2 py-1 text-xs font-medium bg-amber-500/20 text-amber-400 rounded-full">
                    Master Warehouse
                  </span>
                ) : (
                  <span className="px-2 py-1 text-xs font-medium bg-neutral-800 text-neutral-400 rounded-full">
                    Regular Site
                  </span>
                )}
              </td>
              {canManage && (
                <td className="px-6 py-4 whitespace-nowrap text-right">
                  <div className="flex items-center justify-end space-x-2">
                    {!site.is_master && (
                      <>
                        <button
                          onClick={() => handleSetMaster(site.id, site.name)}
                          disabled={settingMaster === site.id}
                          className="px-3 py-1.5 text-xs text-amber-400 hover:text-amber-300 hover:bg-amber-500/10 rounded-lg transition-colors disabled:opacity-50"
                          title="Set as master warehouse"
                        >
                          {settingMaster === site.id ? 'Setting...' : 'Set Master'}
                        </button>
                        <Link
                          href={`/sites/${site.id}/edit`}
                          className="px-3 py-1.5 text-xs text-blue-400 hover:text-blue-300 hover:bg-blue-500/10 rounded-lg transition-colors"
                        >
                          Edit
                        </Link>
                      </>
                    )}
                    <button
                      onClick={() => handleDelete(site.id, site.name, site.is_master)}
                      disabled={deleting === site.id || site.is_master}
                      className="px-3 py-1.5 text-xs text-red-400 hover:text-red-300 hover:bg-red-500/10 rounded-lg transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                      title={site.is_master ? 'Master warehouse cannot be deleted' : undefined}
                    >
                      {deleting === site.id ? 'Deleting...' : 'Delete'}
                    </button>
                  </div>
                </td>
              )}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}

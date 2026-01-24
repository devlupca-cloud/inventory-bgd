import ProtectedRoute from '@/components/auth/ProtectedRoute'
import AppHeaderWrapper from '@/components/layout/AppHeader'
import { getSiteServer } from '@/lib/queries/sites.server'
import { getSiteReceiptsByMonth } from '@/lib/queries/site-receipts.server'
import { hasSiteAccess } from '@/lib/utils/permissions'
import { notFound, redirect } from 'next/navigation'
import Link from 'next/link'

export default async function SiteReceivedPage({
  params,
}: {
  params: Promise<{ siteId: string }>
}) {
  return (
    <ProtectedRoute>
      <SiteReceivedContent params={params} />
    </ProtectedRoute>
  )
}

async function SiteReceivedContent({
  params,
}: {
  params: Promise<{ siteId: string }>
}) {
  const { siteId } = await params

  const canAccess = await hasSiteAccess(siteId)
  if (!canAccess) {
    redirect('/')
  }

  const site = await getSiteServer(siteId)
  if (!site) notFound()

  const months = await getSiteReceiptsByMonth(siteId, 12)

  return (
    <div className="min-h-screen bg-black">
      <AppHeaderWrapper variant="simple" title={`${site.name} • Received`} backHref={`/inventory/${siteId}`} />

      <main className="lg:ml-64 max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h1 className="text-2xl font-bold text-white">Received by Month</h1>
            <p className="text-sm text-neutral-500 mt-1">
              What this site received (Purchase Requests vs Master stock).
            </p>
          </div>
          <Link
            href={`/inventory/${siteId}`}
            className="px-3 py-2 rounded-lg bg-neutral-800 hover:bg-neutral-700 text-sm text-neutral-200 transition-colors"
          >
            Back to Site
          </Link>
        </div>

        {months.length === 0 ? (
          <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-8 text-center text-neutral-500">
            No received movements yet.
          </div>
        ) : (
          <div className="space-y-6">
            {months.map((m) => (
              <div key={`${m.year}-${m.month}`} className="bg-neutral-900 border border-neutral-800 rounded-xl overflow-hidden">
                <div className="px-6 py-4 border-b border-neutral-800 flex items-center justify-between">
                  <div>
                    <h2 className="text-lg font-semibold text-white">{m.monthName}</h2>
                    <p className="text-xs text-neutral-500 mt-1">
                      Total qty: {m.totalQuantity.toLocaleString()} • Total value: R$ {m.totalValue.toFixed(2)}
                      {m.totalValueIsEstimate && <span className="ml-2 text-neutral-600">(includes estimates)</span>}
                    </p>
                  </div>
                  <div className="text-right text-sm">
                    <div className="text-neutral-400">
                      PR: <span className="text-blue-400 font-medium">{m.bySource.purchase_request.quantity.toLocaleString()}</span>
                    </div>
                    <div className="text-neutral-400">
                      Master: <span className="text-green-400 font-medium">{m.bySource.master_stock.quantity.toLocaleString()}</span>
                    </div>
                  </div>
                </div>

                <div className="px-6 py-4 overflow-x-auto">
                  <table className="min-w-full">
                    <thead>
                      <tr className="border-b border-neutral-800">
                        <th className="px-3 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Date</th>
                        <th className="px-3 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Product</th>
                        <th className="px-3 py-2 text-right text-xs font-medium text-neutral-500 uppercase">Qty</th>
                        <th className="px-3 py-2 text-left text-xs font-medium text-neutral-500 uppercase">Source</th>
                        <th className="px-3 py-2 text-right text-xs font-medium text-neutral-500 uppercase">Value</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-neutral-800">
                      {m.rows.map((r, idx) => (
                        <tr key={`${r.created_at}-${r.product_id}-${idx}`}>
                          <td className="px-3 py-2 text-sm text-neutral-400 whitespace-nowrap">
                            {new Date(r.created_at).toLocaleDateString('pt-BR')}
                          </td>
                          <td className="px-3 py-2 text-sm text-white">
                            {r.product_name} <span className="text-xs text-neutral-500">({r.product_unit})</span>
                          </td>
                          <td className="px-3 py-2 text-sm text-neutral-200 text-right">
                            {r.quantity.toLocaleString()}
                          </td>
                          <td className="px-3 py-2 text-sm">
                            {r.source === 'purchase_request' ? (
                              <span className="text-blue-400">Purchase Request</span>
                            ) : (
                              <span className="text-green-400">Master stock</span>
                            )}
                          </td>
                          <td className="px-3 py-2 text-sm text-right">
                            {r.total_value === null ? (
                              <span className="text-neutral-500">—</span>
                            ) : (
                              <span className={r.total_value_is_estimate ? 'text-neutral-400' : 'text-white'}>
                                R$ {r.total_value.toFixed(2)}
                                {r.total_value_is_estimate && <span className="text-xs text-neutral-600"> (est.)</span>}
                              </span>
                            )}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              </div>
            ))}
          </div>
        )}
      </main>
    </div>
  )
}


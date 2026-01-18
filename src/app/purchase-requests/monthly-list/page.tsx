import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getMonthlyPurchaseList } from '@/lib/queries/monthly-purchase-list.server'
import { hasRole } from '@/lib/utils/permissions'
import AppHeaderWrapper from '@/components/layout/AppHeader'
import Link from 'next/link'
import { redirect } from 'next/navigation'

export default async function MonthlyPurchaseListPage({
  searchParams,
}: {
  searchParams: Promise<{ year?: string; month?: string }>
}) {
  return (
    <ProtectedRoute requiredRoles={['manager', 'owner']}>
      <MonthlyPurchaseListContent searchParams={searchParams} />
    </ProtectedRoute>
  )
}

async function MonthlyPurchaseListContent({
  searchParams,
}: {
  searchParams: Promise<{ year?: string; month?: string }>
}) {
  const params = await searchParams
  const canManage = await hasRole(['manager', 'owner'])
  
  // Default to current month
  const today = new Date()
  const year = params.year ? parseInt(params.year) : today.getFullYear()
  const month = params.month ? parseInt(params.month) : today.getMonth() + 1
  
  // Validate month
  if (month < 1 || month > 12) {
    redirect('/purchase-requests/monthly-list')
  }
  
  const purchaseList = await getMonthlyPurchaseList(year, month)
  
  return (
    <div className="min-h-screen bg-black">
      <AppHeaderWrapper variant="simple" title="Monthly Purchase List" backHref="/purchase-requests" />
      
      <main className="lg:ml-64 max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        {/* Header with month selector */}
        <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-6 mb-6">
          <div className="flex justify-between items-center mb-4">
            <div>
              <h2 className="text-2xl font-bold text-white">
                Purchase List - {purchaseList.month} {purchaseList.year}
              </h2>
              <p className="text-neutral-400 mt-1">
                Purchase history: Items actually purchased and received in this month
              </p>
            </div>
            <div className="flex items-center space-x-4">
              {(() => {
                const prevMonth = month === 1 ? 12 : month - 1
                const prevYear = month === 1 ? year - 1 : year
                const nextMonth = month === 12 ? 1 : month + 1
                const nextYear = month === 12 ? year + 1 : year
                return (
                  <>
                    <Link
                      href={`/purchase-requests/monthly-list?year=${prevYear}&month=${prevMonth}`}
                      className="px-4 py-2 bg-neutral-800 border border-neutral-700 rounded-lg text-neutral-300 hover:bg-neutral-700 transition-colors"
                    >
                      ← Previous
                    </Link>
                    <Link
                      href={`/purchase-requests/monthly-list?year=${nextYear}&month=${nextMonth}`}
                      className="px-4 py-2 bg-neutral-800 border border-neutral-700 rounded-lg text-neutral-300 hover:bg-neutral-700 transition-colors"
                    >
                      Next →
                    </Link>
                  </>
                )
              })()}
            </div>
          </div>
          
          {/* Summary */}
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
            <div className="bg-neutral-800 rounded-lg p-4">
              <p className="text-sm text-neutral-400">Products Purchased</p>
              <p className="text-2xl font-bold text-white mt-1">
                {purchaseList.items.length}
              </p>
            </div>
            <div className="bg-neutral-800 rounded-lg p-4">
              <p className="text-sm text-neutral-400">Total Quantity</p>
              <p className="text-2xl font-bold text-green-400 mt-1">
                {purchaseList.totalItems.toLocaleString()}
              </p>
            </div>
            <div className="bg-neutral-800 rounded-lg p-4">
              <p className="text-sm text-neutral-400">Total Spent</p>
              <p className="text-2xl font-bold text-amber-400 mt-1">
                R$ {purchaseList.totalValue.toFixed(2)}
              </p>
            </div>
          </div>
        </div>
        
        {purchaseList.items.length === 0 ? (
          <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-12 text-center">
            <div className="w-16 h-16 bg-neutral-800 rounded-full flex items-center justify-center mx-auto mb-4">
              <svg className="w-8 h-8 text-neutral-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
              </svg>
            </div>
            <h3 className="text-lg font-semibold text-white mb-2">No Purchase Requests</h3>
            <p className="text-neutral-500">No purchase requests found for this month.</p>
          </div>
        ) : (
          <div className="bg-neutral-900 border border-neutral-800 rounded-xl overflow-hidden">
            <div className="overflow-x-auto">
              <table className="min-w-full">
                <thead>
                  <tr className="border-b border-neutral-800">
                    <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                      Product
                    </th>
                    <th className="px-6 py-3 text-right text-xs font-medium text-neutral-500 uppercase tracking-wider">
                      Quantity Purchased
                    </th>
                    <th className="px-6 py-3 text-right text-xs font-medium text-neutral-500 uppercase tracking-wider">
                      Unit Price
                    </th>
                    <th className="px-6 py-3 text-right text-xs font-medium text-neutral-500 uppercase tracking-wider">
                      Subtotal
                    </th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-neutral-800">
                  {purchaseList.items.map((item) => (
                    <tr key={item.product_id} className="hover:bg-neutral-800/50 transition-colors">
                      <td className="px-6 py-4 whitespace-nowrap">
                        <div className="flex items-center">
                          <div className="w-10 h-10 bg-green-500/20 rounded-lg flex items-center justify-center mr-3">
                            <svg className="w-5 h-5 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                            </svg>
                          </div>
                          <div>
                            <span className="text-sm font-medium text-white">{item.product_name}</span>
                            <span className="text-xs text-neutral-400 ml-2">({item.product_unit})</span>
                          </div>
                        </div>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-right">
                        <span className="text-sm font-bold text-green-400">
                          {item.quantity_to_purchase.toLocaleString()}
                        </span>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-right">
                        <span className="text-sm text-neutral-400">
                          R$ {(item.unit_price || 0).toFixed(2)}
                        </span>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-right">
                        <span className="text-sm font-medium text-green-400">
                          R$ {(item.quantity_to_purchase * (item.unit_price || 0)).toFixed(2)}
                        </span>
                      </td>
                    </tr>
                  ))}
                </tbody>
                <tfoot className="bg-neutral-800/50">
                  <tr>
                    <td colSpan={5} className="px-6 py-3 text-right text-sm font-medium text-neutral-400">
                      Grand Total:
                    </td>
                    <td className="px-6 py-3 text-right text-sm font-bold text-green-400">
                      R$ {purchaseList.totalValue.toFixed(2)}
                    </td>
                  </tr>
                </tfoot>
              </table>
            </div>
          </div>
        )}
      </main>
    </div>
  )
}

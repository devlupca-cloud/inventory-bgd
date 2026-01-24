import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getMonthlyPurchaseOverview } from '@/lib/queries/monthly-purchase-overview.server'
import AppHeaderWrapper from '@/components/layout/AppHeader'
import Link from 'next/link'
import MonthlyChart from '@/components/purchase-requests/MonthlyChart'

export default async function MonthlyPurchaseOverviewPage() {
  return (
    <ProtectedRoute requiredRoles={['manager', 'owner']}>
      <MonthlyPurchaseOverviewContent />
    </ProtectedRoute>
  )
}

async function MonthlyPurchaseOverviewContent() {
  const monthlyData = await getMonthlyPurchaseOverview()
  
  // Calculate max value for chart scaling
  const maxValue = monthlyData.length > 0 
    ? Math.max(...monthlyData.map(d => d.totalValue))
    : 0

  return (
    <div className="min-h-screen bg-black">
      <AppHeaderWrapper variant="simple" title="Monthly Purchase Overview" backHref="/purchase-requests" />
      
      <main className="lg:ml-64 max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        {/* Header */}
        <div className="mb-6">
          <h2 className="text-2xl font-bold text-white mb-2">Purchase History by Month</h2>
          <p className="text-neutral-400">View spending trends and access detailed monthly purchase lists</p>
        </div>

        {monthlyData.length === 0 ? (
          <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-12 text-center">
            <div className="w-16 h-16 bg-neutral-800 rounded-full flex items-center justify-center mx-auto mb-4">
              <svg className="w-8 h-8 text-neutral-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
              </svg>
            </div>
            <h3 className="text-lg font-semibold text-white mb-2">No Purchase Data</h3>
            <p className="text-neutral-500">No purchase requests have been received yet.</p>
          </div>
        ) : (
          <>
            {/* Chart */}
            <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-6 mb-6">
              <h3 className="text-lg font-semibold text-white mb-4">Spending by Month</h3>
              <MonthlyChart data={monthlyData} maxValue={maxValue} />
            </div>

            {/* Monthly List */}
            <div className="bg-neutral-900 border border-neutral-800 rounded-xl overflow-hidden">
              <div className="px-6 py-4 bg-neutral-800 border-b border-neutral-700">
                <h3 className="text-lg font-semibold text-white">Monthly Purchase Lists</h3>
              </div>
              
              <div className="divide-y divide-neutral-800">
                {monthlyData.map((month) => (
                  <Link
                    key={`${month.year}-${month.month}`}
                    href={`/purchase-requests/monthly-list?year=${month.year}&month=${month.month}`}
                    className="block px-6 py-4 hover:bg-neutral-800/50 transition-colors"
                  >
                    <div className="flex items-center justify-between">
                      <div className="flex-1">
                        <div className="flex items-center space-x-3">
                          <div className="w-12 h-12 bg-green-500/20 rounded-lg flex items-center justify-center">
                            <span className="text-green-400 font-semibold text-sm">
                              {month.monthName.substring(0, 3)}
                            </span>
                          </div>
                          <div>
                            <h4 className="text-lg font-semibold text-white">
                              {month.monthName} {month.year}
                            </h4>
                            <p className="text-sm text-neutral-400">
                              {month.requestCount} request{month.requestCount !== 1 ? 's' : ''} • {month.totalItems.toLocaleString()} items
                            </p>
                          </div>
                        </div>
                      </div>
                      <div className="text-right">
                        <p className="text-xl font-bold text-green-400">
                          $ {month.totalValue.toFixed(2)}
                        </p>
                        <p className="text-xs text-neutral-500 mt-1">Total spent</p>
                      </div>
                      <div className="ml-4">
                        <svg className="w-5 h-5 text-neutral-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                        </svg>
                      </div>
                    </div>
                  </Link>
                ))}
              </div>
            </div>
          </>
        )}
      </main>
    </div>
  )
}

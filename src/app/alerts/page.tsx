import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getLowStockAlerts } from '@/lib/queries/inventory'
import LowStockAlert from '@/components/inventory/LowStockAlert'
import Link from 'next/link'

export default async function AlertsPage() {
  return (
    <ProtectedRoute>
      <AlertsContent />
    </ProtectedRoute>
  )
}

async function AlertsContent() {
  const alerts = await getLowStockAlerts()

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
              <h1 className="text-xl font-bold text-white">Low Stock Alerts</h1>
            </div>
          </div>
        </div>
      </nav>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        {alerts.length === 0 ? (
          <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-12 text-center">
            <div className="w-16 h-16 bg-green-500/20 rounded-full flex items-center justify-center mx-auto mb-4">
              <svg className="w-8 h-8 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
              </svg>
            </div>
            <h3 className="text-lg font-semibold text-white mb-2">All Good!</h3>
            <p className="text-neutral-500">No low stock alerts at this time.</p>
          </div>
        ) : (
          <div className="space-y-4">
            <div className="flex items-center justify-between mb-6">
              <div>
                <h2 className="text-lg font-semibold text-white">
                  {alerts.length} Alert{alerts.length !== 1 ? 's' : ''}
                </h2>
                <p className="text-sm text-neutral-500">Items below minimum stock levels</p>
              </div>
            </div>
            {alerts.map((alert) => (
              <LowStockAlert key={`${alert.site_id}-${alert.product_id}`} alert={alert} />
            ))}
          </div>
        )}
      </main>
    </div>
  )
}

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
    <div className="min-h-screen bg-gray-50">
      <nav className="bg-white shadow">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center space-x-4">
              <Link href="/inventory" className="text-gray-500 hover:text-gray-700">
                ← Back to Inventory
              </Link>
              <h1 className="text-xl font-semibold text-gray-900">Low Stock Alerts</h1>
            </div>
          </div>
        </div>
      </nav>

      <main className="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <div className="px-4 py-6 sm:px-0">
          {alerts.length === 0 ? (
            <div className="bg-white shadow rounded-lg p-6 text-center">
              <p className="text-gray-500">No low stock alerts at this time.</p>
            </div>
          ) : (
            <div className="space-y-4">
              {alerts.map((alert) => (
                <LowStockAlert key={`${alert.site_id}-${alert.product_id}`} alert={alert} />
              ))}
            </div>
          )}
        </div>
      </main>
    </div>
  )
}

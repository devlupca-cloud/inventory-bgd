'use client'
import Dialog from '@/components/ui/Dialog'
import { useEffect, useState } from 'react'
import { getLowStockAlerts } from '@/lib/queries/inventory'
import LowStockAlert from '@/components/inventory/LowStockAlert'

interface AlertsModalProps {
  isOpen: boolean
  onClose: () => void
}

export default function AlertsModal({ isOpen, onClose }: AlertsModalProps) {
  const [alerts, setAlerts] = useState<any[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (isOpen) {
      loadAlerts()
    }
  }, [isOpen])

  const loadAlerts = async () => {
    setLoading(true)
    try {
      const data = await getLowStockAlerts()
      setAlerts(data)
    } catch (err) {
      console.error('Error loading alerts:', err)
    } finally {
      setLoading(false)
    }
  }

  return (
    <Dialog isOpen={isOpen} onClose={onClose} title="Low Stock Alerts" size="xl">
      {loading ? (
        <div className="flex items-center justify-center py-12">
          <div className="text-neutral-400">Loading alerts...</div>
        </div>
      ) : alerts.length === 0 ? (
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
          <div className="flex items-center justify-between mb-4">
            <div>
              <h3 className="text-sm font-semibold text-white">
                {alerts.length} Alert{alerts.length !== 1 ? 's' : ''}
              </h3>
              <p className="text-xs text-neutral-500">Items below minimum stock levels</p>
            </div>
          </div>
          <div className="space-y-3 max-h-[60vh] overflow-y-auto">
            {alerts.map((alert) => (
              <LowStockAlert key={`${alert.site_id}-${alert.product_id}`} alert={alert} />
            ))}
          </div>
        </div>
      )}
    </Dialog>
  )
}

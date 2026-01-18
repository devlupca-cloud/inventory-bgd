'use client'
import { useState } from 'react'
import StockInModal from '@/components/modals/StockInModal'
import StockOutModal from '@/components/modals/StockOutModal'
import TransferModal from '@/components/modals/TransferModal'
import AlertsModal from '@/components/modals/AlertsModal'

export default function QuickActions() {
  const [stockInOpen, setStockInOpen] = useState(false)
  const [stockOutOpen, setStockOutOpen] = useState(false)
  const [transferOpen, setTransferOpen] = useState(false)
  const [alertsOpen, setAlertsOpen] = useState(false)

  return (
    <>
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
        <button
          onClick={() => setStockInOpen(true)}
          className="flex flex-col items-center justify-center p-4 bg-green-500/10 border border-green-500/30 rounded-xl hover:bg-green-500/20 hover:border-green-500/50 transition-all group"
        >
          <div className="w-12 h-12 bg-green-500/20 rounded-xl flex items-center justify-center mb-2 group-hover:bg-green-500/30 transition-colors">
            <svg className="w-6 h-6 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
            </svg>
          </div>
          <span className="text-sm font-medium text-green-500">Stock IN</span>
        </button>

        <button
          onClick={() => setStockOutOpen(true)}
          className="flex flex-col items-center justify-center p-4 bg-red-500/10 border border-red-500/30 rounded-xl hover:bg-red-500/20 hover:border-red-500/50 transition-all group"
        >
          <div className="w-12 h-12 bg-red-500/20 rounded-xl flex items-center justify-center mb-2 group-hover:bg-red-500/30 transition-colors">
            <svg className="w-6 h-6 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 12H4" />
            </svg>
          </div>
          <span className="text-sm font-medium text-red-500">Stock OUT</span>
        </button>

        <button
          onClick={() => setTransferOpen(true)}
          className="flex flex-col items-center justify-center p-4 bg-blue-500/10 border border-blue-500/30 rounded-xl hover:bg-blue-500/20 hover:border-blue-500/50 transition-all group"
        >
          <div className="w-12 h-12 bg-blue-500/20 rounded-xl flex items-center justify-center mb-2 group-hover:bg-blue-500/30 transition-colors">
            <svg className="w-6 h-6 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
            </svg>
          </div>
          <span className="text-sm font-medium text-blue-500">Transfer</span>
        </button>

        <button
          onClick={() => setAlertsOpen(true)}
          className="flex flex-col items-center justify-center p-4 bg-amber-500/10 border border-amber-500/30 rounded-xl hover:bg-amber-500/20 hover:border-amber-500/50 transition-all group relative"
        >
          <div className="w-12 h-12 bg-amber-500/20 rounded-xl flex items-center justify-center mb-2 group-hover:bg-amber-500/30 transition-colors">
            <svg className="w-6 h-6 text-amber-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
            </svg>
          </div>
          <span className="text-sm font-medium text-amber-500">Alerts</span>
        </button>
      </div>

      <StockInModal isOpen={stockInOpen} onClose={() => setStockInOpen(false)} />
      <StockOutModal isOpen={stockOutOpen} onClose={() => setStockOutOpen(false)} />
      <TransferModal isOpen={transferOpen} onClose={() => setTransferOpen(false)} />
      <AlertsModal isOpen={alertsOpen} onClose={() => setAlertsOpen(false)} />
    </>
  )
}

'use client'
import { useState } from 'react'
import Link from 'next/link'
import TransferModal from '@/components/modals/TransferModal'
import AlertsModal from '@/components/modals/AlertsModal'

export default function QuickActions() {
  const [transferOpen, setTransferOpen] = useState(false)
  const [directPurchaseOpen, setDirectPurchaseOpen] = useState(false)
  const [alertsOpen, setAlertsOpen] = useState(false)

  return (
    <>
      <div className="grid grid-cols-3 gap-3">
        <button
          onClick={() => setTransferOpen(true)}
          className="flex flex-col items-center justify-center p-5 bg-blue-500/10 border border-blue-500/30 rounded-xl hover:bg-blue-500/20 hover:border-blue-500/50 transition-all group h-28"
        >
          <div className="w-12 h-12 bg-blue-500/20 rounded-xl flex items-center justify-center mb-2 group-hover:bg-blue-500/30 transition-colors">
            <svg className="w-6 h-6 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
            </svg>
          </div>
          <span className="text-sm font-medium text-blue-500">Transfer</span>
        </button>

        <button
          onClick={() => setDirectPurchaseOpen(true)}
          className="flex flex-col items-center justify-center p-5 bg-green-500/10 border border-green-500/30 rounded-xl hover:bg-green-500/20 hover:border-green-500/50 transition-all group h-28"
        >
          <div className="w-12 h-12 bg-green-500/20 rounded-xl flex items-center justify-center mb-2 group-hover:bg-green-500/30 transition-colors">
            <svg className="w-6 h-6 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
            </svg>
          </div>
          <span className="text-sm font-medium text-green-500">Direct Purchase</span>
        </button>

        <Link
          href="/purchase-requests/new"
          className="flex flex-col items-center justify-center p-5 bg-amber-500/10 border border-amber-500/30 rounded-xl hover:bg-amber-500/20 hover:border-amber-500/50 transition-all group h-28"
        >
          <div className="w-12 h-12 bg-amber-500/20 rounded-xl flex items-center justify-center mb-2 group-hover:bg-amber-500/30 transition-colors">
            <svg className="w-6 h-6 text-amber-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
            </svg>
          </div>
          <span className="text-sm font-medium text-amber-500">New Request</span>
        </Link>
      </div>

      <TransferModal isOpen={transferOpen} onClose={() => setTransferOpen(false)} />
      <AlertsModal isOpen={alertsOpen} onClose={() => setAlertsOpen(false)} />
    </>
  )
}

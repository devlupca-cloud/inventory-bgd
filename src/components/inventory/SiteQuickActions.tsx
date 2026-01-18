'use client'
import { useState } from 'react'
import Link from 'next/link'
import StockInModal from '@/components/modals/StockInModal'
import StockOutModal from '@/components/modals/StockOutModal'
import TransferModal from '@/components/modals/TransferModal'

interface SiteQuickActionsProps {
  siteId: string
  canManage: boolean
  canSupervise: boolean
}

export default function SiteQuickActions({ siteId, canManage, canSupervise }: SiteQuickActionsProps) {
  const [stockInOpen, setStockInOpen] = useState(false)
  const [stockOutOpen, setStockOutOpen] = useState(false)
  const [transferOpen, setTransferOpen] = useState(false)

  return (
    <>
      <div className="grid grid-cols-2 gap-3">
        {canManage && (
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
        )}

        {canSupervise && (
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
        )}

        {canManage && (
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
        )}

        <Link
          href={`/purchase-requests/new?siteId=${siteId}`}
          className="flex flex-col items-center justify-center p-4 bg-amber-500/10 border border-amber-500/30 rounded-xl hover:bg-amber-500/20 hover:border-amber-500/50 transition-all group"
        >
          <div className="w-12 h-12 bg-amber-500/20 rounded-xl flex items-center justify-center mb-2 group-hover:bg-amber-500/30 transition-colors">
            <svg className="w-6 h-6 text-amber-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
            </svg>
          </div>
          <span className="text-sm font-medium text-amber-500">New Request</span>
        </Link>
      </div>

      {/* Modals */}
      <StockInModal isOpen={stockInOpen} onClose={() => setStockInOpen(false)} initialSiteId={siteId} />
      <StockOutModal isOpen={stockOutOpen} onClose={() => setStockOutOpen(false)} initialSiteId={siteId} />
      <TransferModal isOpen={transferOpen} onClose={() => setTransferOpen(false)} initialFromSiteId={siteId} />
    </>
  )
}

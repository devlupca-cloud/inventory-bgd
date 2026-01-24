'use client'
import { useState } from 'react'
import Link from 'next/link'
import TransferModal from '@/components/modals/TransferModal'

interface InventoryActionsProps {
  siteId: string
  productId: string
  canManage: boolean
  canSupervise: boolean
  isMaster?: boolean
}

export default function InventoryActions({ siteId, productId, canManage, isMaster }: InventoryActionsProps) {
  const [transferOpen, setTransferOpen] = useState(false)

  return (
    <>
      <div className="flex items-center justify-end space-x-2">
        {canManage && (
          <button
            onClick={() => setTransferOpen(true)}
            className="px-2 py-1 text-xs text-blue-400 hover:text-blue-300 hover:bg-blue-500/10 rounded transition-colors"
            title="Transfer"
          >
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
            </svg>
          </button>
        )}
        <Link
          href={isMaster ? '/inventory/master' : `/inventory/${siteId}`}
          className="px-2 py-1 text-xs text-neutral-400 hover:text-white hover:bg-neutral-700 rounded transition-colors"
          title="View Site"
        >
          <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
          </svg>
        </Link>
      </div>

      <TransferModal isOpen={transferOpen} onClose={() => setTransferOpen(false)} initialFromSiteId={siteId} initialProductId={productId} />
    </>
  )
}

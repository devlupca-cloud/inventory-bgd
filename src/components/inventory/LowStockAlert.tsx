'use client'
import { LowStockAlert as LowStockAlertType } from '@/lib/queries/inventory'
import Badge from '@/components/ui/Badge'
import Link from 'next/link'

interface LowStockAlertProps {
  alert: LowStockAlertType
}

export default function LowStockAlert({ alert }: LowStockAlertProps) {
  return (
    <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-5 border-l-4 border-l-red-500">
      <div className="flex items-center justify-between">
        <div className="flex-1">
          <h3 className="text-sm font-semibold text-white">
            {alert.product_name}
          </h3>
          <p className="text-sm text-neutral-500 mt-0.5">
            {alert.site_name}
          </p>
        </div>
        <div className="ml-4 text-right">
          <div className="text-sm text-neutral-300">
            <span className="text-red-400 font-semibold">{alert.quantity_on_hand.toLocaleString()}</span>
            <span className="text-neutral-600 mx-1">/</span>
            <span className="text-neutral-400">{alert.min_level.toLocaleString()}</span>
          </div>
          <Badge variant="danger">
            -{alert.shortage.toLocaleString()} shortage
          </Badge>
        </div>
      </div>
      <div className="mt-3 pt-3 border-t border-neutral-800">
        <Link
          href={`/inventory/${alert.site_id}`}
          className="text-sm text-green-500 hover:text-green-400 transition-colors flex items-center"
        >
          View inventory
          <svg className="w-4 h-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
          </svg>
        </Link>
      </div>
    </div>
  )
}

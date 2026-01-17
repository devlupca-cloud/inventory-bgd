'use client'
import { LowStockAlert as LowStockAlertType } from '@/lib/queries/inventory'
import Badge from '@/components/ui/Badge'
import Link from 'next/link'

interface LowStockAlertProps {
  alert: LowStockAlertType
}

export default function LowStockAlert({ alert }: LowStockAlertProps) {
  return (
    <div className="bg-white shadow rounded-lg p-4 border-l-4 border-red-500">
      <div className="flex items-center justify-between">
        <div className="flex-1">
          <h3 className="text-sm font-medium text-gray-900">
            {alert.product_name}
          </h3>
          <p className="text-sm text-gray-500">
            {alert.site_name}
          </p>
        </div>
        <div className="ml-4 text-right">
          <div className="text-sm font-medium text-gray-900">
            {alert.quantity_on_hand.toLocaleString()} / {alert.min_level.toLocaleString()}
          </div>
          <Badge variant="danger">
            Shortage: {alert.shortage.toLocaleString()}
          </Badge>
        </div>
      </div>
      <div className="mt-2">
        <Link
          href={`/inventory/${alert.site_id}`}
          className="text-sm text-blue-600 hover:text-blue-800"
        >
          View inventory →
        </Link>
      </div>
    </div>
  )
}

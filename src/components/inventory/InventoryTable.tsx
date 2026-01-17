'use client'
import { SiteInventoryItem } from '@/lib/queries/inventory'

interface InventoryTableProps {
  items: SiteInventoryItem[]
  onProductClick?: (productId: string) => void
}

export default function InventoryTable({ items, onProductClick }: InventoryTableProps) {
  if (items.length === 0) {
    return (
      <div className="text-center py-12 text-neutral-500">
        <svg className="w-12 h-12 mx-auto mb-4 text-neutral-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
        </svg>
        <p>No inventory items found for this site.</p>
      </div>
    )
  }

  return (
    <div className="overflow-x-auto">
      <table className="min-w-full">
        <thead>
          <tr className="border-b border-neutral-800">
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Product
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Quantity
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Unit
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Last Updated
            </th>
          </tr>
        </thead>
        <tbody className="divide-y divide-neutral-800">
          {items.map((item) => (
            <tr
              key={`${item.site_id}-${item.product_id}`}
              className={`${onProductClick ? 'hover:bg-neutral-800/50 cursor-pointer' : ''} transition-colors`}
              onClick={() => onProductClick?.(item.product_id)}
            >
              <td className="px-6 py-4 whitespace-nowrap">
                <span className="text-sm font-medium text-white">{item.product.name}</span>
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <span className={`text-sm font-semibold ${item.quantity_on_hand > 0 ? 'text-green-400' : 'text-red-400'}`}>
                  {item.quantity_on_hand.toLocaleString()}
                </span>
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <span className="text-sm text-neutral-400">{item.product.unit}</span>
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <span className="text-sm text-neutral-500">
                  {new Date(item.last_updated).toLocaleDateString()}
                </span>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}

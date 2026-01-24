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
            <th className="px-6 py-3 text-right text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Quantity
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Unit
            </th>
            <th className="px-6 py-3 text-right text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Unit Price
            </th>
            <th className="px-6 py-3 text-right text-xs font-medium text-neutral-500 uppercase tracking-wider">
              Total Value
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
              <td className="px-6 py-4 whitespace-nowrap text-right">
                <div className="flex flex-col items-end">
                  <span className={`text-sm font-semibold ${item.quantity_on_hand > 0 ? 'text-green-400' : 'text-red-400'}`}>
                    {item.quantity_on_hand.toLocaleString()} {item.product.base_unit || item.product.unit}
                  </span>
                  {item.product.units_per_package > 1 && (
                    <div className="text-xs text-neutral-500 mt-0.5 space-y-0.5">
                      {item.quantity_packages > 0 && (
                        <div>
                          {item.quantity_packages} {item.product.unit}(s) fechada(s)
                        </div>
                      )}
                      {item.quantity_loose_units > 0 && (
                        <div>
                          {item.quantity_loose_units.toLocaleString()} {item.product.base_unit}(s) solta(s)
                        </div>
                      )}
                      {item.quantity_packages === 0 && item.quantity_loose_units === 0 && item.quantity_on_hand === 0 && (
                        <div className="text-red-400">Sem estoque</div>
                      )}
                    </div>
                  )}
                </div>
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <span className="text-sm text-neutral-400">{item.product.base_unit || item.product.unit}</span>
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-right">
                <span className="text-sm text-neutral-400">
                  R$ {(item.product.price || 0).toFixed(2)}
                </span>
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-right">
                <span className="text-sm font-medium text-green-400">
                  R$ {((item.product.price || 0) * item.quantity_on_hand).toFixed(2)}
                </span>
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

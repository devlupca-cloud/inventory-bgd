'use client'
import { useState, useMemo } from 'react'
import Link from 'next/link'
import InventoryActions from './InventoryActions'
import Select from '@/components/ui/Select'

interface InventoryItem {
  site_id: string
  product_id: string
  quantity_on_hand: number
  last_updated: string
  product: {
    id: string
    name: string
    unit: string
    price: number
  }
  site: {
    id: string
    name: string
    address: string | null
    is_master: boolean
  }
}

interface SortableTableProps {
  items: InventoryItem[]
  canManage: boolean
  canSupervise: boolean
  products: Array<{ id: string; name: string }>
  sites: Array<{ id: string; name: string }>
}

type SortField = 'product' | 'site' | 'quantity' | 'unit_price' | 'total_value' | 'last_updated'
type SortDirection = 'asc' | 'desc'

export default function SortableTable({ items, canManage, canSupervise, products, sites }: SortableTableProps) {
  const [sortField, setSortField] = useState<SortField>('product')
  const [sortDirection, setSortDirection] = useState<SortDirection>('asc')
  const [filterProduct, setFilterProduct] = useState<string>('')
  const [filterSite, setFilterSite] = useState<string>('')

  const handleSort = (field: SortField) => {
    if (sortField === field) {
      // Toggle direction if clicking the same field
      setSortDirection(sortDirection === 'asc' ? 'desc' : 'asc')
    } else {
      // Set new field with ascending direction
      setSortField(field)
      setSortDirection('asc')
    }
  }

  const filteredAndSortedItems = useMemo(() => {
    // First apply filters
    let filtered = items
    
    if (filterProduct) {
      filtered = filtered.filter(item => item.product_id === filterProduct)
    }
    
    if (filterSite) {
      filtered = filtered.filter(item => item.site_id === filterSite)
    }
    
    // Then sort
    const sorted = [...filtered]
    
    sorted.sort((a, b) => {
      let comparison = 0
      
      switch (sortField) {
        case 'product':
          comparison = a.product.name.localeCompare(b.product.name)
          break
        case 'site':
          comparison = a.site.name.localeCompare(b.site.name)
          break
        case 'quantity':
          comparison = a.quantity_on_hand - b.quantity_on_hand
          break
        case 'unit_price':
          comparison = (a.product.price || 0) - (b.product.price || 0)
          break
        case 'total_value':
          comparison = ((a.product.price || 0) * a.quantity_on_hand) - ((b.product.price || 0) * b.quantity_on_hand)
          break
        case 'last_updated':
          comparison = new Date(a.last_updated).getTime() - new Date(b.last_updated).getTime()
          break
      }
      
      return sortDirection === 'asc' ? comparison : -comparison
    })
    
    return sorted
  }, [items, sortField, sortDirection, filterProduct, filterSite])

  const SortIcon = ({ field }: { field: SortField }) => {
    if (sortField !== field) {
      return (
        <svg className="w-4 h-4 text-neutral-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4" />
        </svg>
      )
    }
    
    if (sortDirection === 'asc') {
      return (
        <svg className="w-4 h-4 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 15l7-7 7 7" />
        </svg>
      )
    }
    
    return (
      <svg className="w-4 h-4 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
      </svg>
    )
  }

  return (
    <div className="space-y-4">
      {/* Filters */}
      <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-4">
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div>
            <Select
              id="filter-product"
              label="Filter by Product"
              value={filterProduct}
              onChange={(e) => setFilterProduct(e.target.value)}
            >
              <option value="">All Products</option>
              {products.map((product) => (
                <option key={product.id} value={product.id}>
                  {product.name}
                </option>
              ))}
            </Select>
          </div>
          <div>
            <Select
              id="filter-site"
              label="Filter by Site"
              value={filterSite}
              onChange={(e) => setFilterSite(e.target.value)}
            >
              <option value="">All Sites</option>
              {sites.map((site) => (
                <option key={site.id} value={site.id}>
                  {site.name}
                </option>
              ))}
            </Select>
          </div>
        </div>
        {(filterProduct || filterSite) && (
          <div className="mt-4 flex items-center justify-between">
            <span className="text-sm text-neutral-400">
              Showing {filteredAndSortedItems.length} of {items.length} items
            </span>
            <button
              onClick={() => {
                setFilterProduct('')
                setFilterSite('')
              }}
              className="text-sm text-green-400 hover:text-green-300 transition-colors"
            >
              Clear Filters
            </button>
          </div>
        )}
      </div>

      {/* Table */}
      <div className="bg-neutral-900 border border-neutral-800 rounded-xl overflow-hidden">
        <div className="overflow-x-auto">
          <table className="min-w-full">
          <thead>
            <tr className="border-b border-neutral-800">
              <th 
                className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider cursor-pointer hover:bg-neutral-800/50 transition-colors"
                onClick={() => handleSort('product')}
              >
                <div className="flex items-center space-x-2">
                  <span>Product</span>
                  <SortIcon field="product" />
                </div>
              </th>
              <th 
                className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider cursor-pointer hover:bg-neutral-800/50 transition-colors"
                onClick={() => handleSort('site')}
              >
                <div className="flex items-center space-x-2">
                  <span>Site</span>
                  <SortIcon field="site" />
                </div>
              </th>
              <th 
                className="px-6 py-3 text-right text-xs font-medium text-neutral-500 uppercase tracking-wider cursor-pointer hover:bg-neutral-800/50 transition-colors"
                onClick={() => handleSort('quantity')}
              >
                <div className="flex items-center justify-end space-x-2">
                  <span>Quantity</span>
                  <SortIcon field="quantity" />
                </div>
              </th>
              <th className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider">
                Unit
              </th>
              <th 
                className="px-6 py-3 text-right text-xs font-medium text-neutral-500 uppercase tracking-wider cursor-pointer hover:bg-neutral-800/50 transition-colors"
                onClick={() => handleSort('unit_price')}
              >
                <div className="flex items-center justify-end space-x-2">
                  <span>Unit Price</span>
                  <SortIcon field="unit_price" />
                </div>
              </th>
              <th 
                className="px-6 py-3 text-right text-xs font-medium text-neutral-500 uppercase tracking-wider cursor-pointer hover:bg-neutral-800/50 transition-colors"
                onClick={() => handleSort('total_value')}
              >
                <div className="flex items-center justify-end space-x-2">
                  <span>Total Value</span>
                  <SortIcon field="total_value" />
                </div>
              </th>
              <th 
                className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider cursor-pointer hover:bg-neutral-800/50 transition-colors"
                onClick={() => handleSort('last_updated')}
              >
                <div className="flex items-center space-x-2">
                  <span>Last Updated</span>
                  <SortIcon field="last_updated" />
                </div>
              </th>
              {(canManage || canSupervise) && (
                <th className="px-6 py-3 text-right text-xs font-medium text-neutral-500 uppercase tracking-wider">
                  Actions
                </th>
              )}
            </tr>
          </thead>
          <tbody className="divide-y divide-neutral-800">
            {filteredAndSortedItems.length === 0 ? (
              <tr>
                <td colSpan={canManage || canSupervise ? 8 : 7} className="px-6 py-12 text-center">
                  <div className="text-neutral-500">
                    <svg className="w-12 h-12 mx-auto mb-3 text-neutral-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                    </svg>
                    <p className="text-sm">No items match the selected filters</p>
                  </div>
                </td>
              </tr>
            ) : (
              filteredAndSortedItems.map((item) => (
              <tr key={`${item.site_id}-${item.product_id}`} className="hover:bg-neutral-800/50 transition-colors">
                <td className="px-6 py-4 whitespace-nowrap">
                  <div className="flex items-center">
                    <div className="w-10 h-10 bg-green-500/20 rounded-lg flex items-center justify-center mr-3">
                      <svg className="w-5 h-5 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                      </svg>
                    </div>
                    <span className="text-sm font-medium text-white">{item.product.name}</span>
                  </div>
                </td>
                <td className="px-6 py-4 whitespace-nowrap">
                  <Link 
                    href={`/inventory/${item.site_id}`}
                    className="text-sm text-green-400 hover:text-green-300 hover:underline"
                  >
                    {item.site.name}
                  </Link>
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-right">
                  <span className={`text-sm font-semibold ${item.quantity_on_hand > 0 ? 'text-green-400' : 'text-red-400'}`}>
                    {item.quantity_on_hand.toLocaleString()}
                  </span>
                </td>
                <td className="px-6 py-4 whitespace-nowrap">
                  <span className="text-sm text-neutral-400">{item.product.unit}</span>
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-right">
                  <span className="text-sm text-neutral-400">
                    $ {(item.product.price || 0).toFixed(2)}
                  </span>
                </td>
                <td className="px-6 py-4 whitespace-nowrap text-right">
                  <span className="text-sm font-medium text-green-400">
                    $ {((item.product.price || 0) * item.quantity_on_hand).toFixed(2)}
                  </span>
                </td>
                <td className="px-6 py-4 whitespace-nowrap">
                  <span className="text-sm text-neutral-500">
                    {new Date(item.last_updated).toLocaleDateString()}
                  </span>
                </td>
                {(canManage || canSupervise) && (
                  <td className="px-6 py-4 whitespace-nowrap text-right">
                    <InventoryActions
                      siteId={item.site_id}
                      productId={item.product_id}
                      canManage={canManage}
                      canSupervise={canSupervise}
                      isMaster={item.site.is_master}
                    />
                  </td>
                )}
              </tr>
              ))
            )}
          </tbody>
          </table>
        </div>
      </div>
    </div>
  )
}

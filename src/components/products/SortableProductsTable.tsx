'use client'
import { useState, useMemo } from 'react'
import Link from 'next/link'
import { createClient } from '@/lib/supabase/client'
import { useRouter } from 'next/navigation'
import Input from '@/components/ui/Input'

interface Product {
  id: string
  name: string
  unit: string
  price: number
  created_at: string
  updated_at: string
}

interface SortableProductsTableProps {
  products: Product[]
  canManage: boolean
  totalProducts: number
}

type SortField = 'name' | 'unit' | 'price' | 'created_at'
type SortDirection = 'asc' | 'desc'

export default function SortableProductsTable({ products, canManage, totalProducts }: SortableProductsTableProps) {
  const [sortField, setSortField] = useState<SortField>('name')
  const [sortDirection, setSortDirection] = useState<SortDirection>('asc')
  const [filterName, setFilterName] = useState<string>('')
  const [deleting, setDeleting] = useState<string | null>(null)
  const supabase = createClient()
  const router = useRouter()

  const handleSort = (field: SortField) => {
    if (sortField === field) {
      setSortDirection(sortDirection === 'asc' ? 'desc' : 'asc')
    } else {
      setSortField(field)
      setSortDirection('asc')
    }
  }

  const filteredAndSortedProducts = useMemo(() => {
    // First apply filter
    let filtered = products
    
    if (filterName.trim()) {
      const searchTerm = filterName.trim().toLowerCase()
      filtered = filtered.filter(product => 
        product.name.toLowerCase().includes(searchTerm)
      )
    }
    
    // Then sort
    const sorted = [...filtered]
    
    sorted.sort((a, b) => {
      let comparison = 0
      
      switch (sortField) {
        case 'name':
          comparison = a.name.localeCompare(b.name)
          break
        case 'unit':
          comparison = a.unit.localeCompare(b.unit)
          break
        case 'price':
          comparison = (a.price || 0) - (b.price || 0)
          break
        case 'created_at':
          comparison = new Date(a.created_at).getTime() - new Date(b.created_at).getTime()
          break
      }
      
      return sortDirection === 'asc' ? comparison : -comparison
    })
    
    return sorted
  }, [products, sortField, sortDirection, filterName])

  const handleDelete = async (productId: string, productName: string) => {
    if (!confirm(`Are you sure you want to delete "${productName}"?`)) {
      return
    }

    setDeleting(productId)
    try {
      // Use RPC function for soft delete (bypasses RLS issues)
      const { data, error } = await supabase.rpc('rpc_delete_product', {
        p_product_id: productId
      })

      if (error) {
        console.error('Delete error:', error)
        throw new Error(error.message || 'Failed to delete product')
      }

      if (!data || !data.success) {
        throw new Error(data?.message || 'Failed to delete product')
      }
      
      router.refresh()
    } catch (err: any) {
      console.error('Delete failed:', err)
      alert(err.message || 'Failed to delete product. Make sure you have manager/owner permissions.')
    } finally {
      setDeleting(null)
    }
  }

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

  if (products.length === 0) {
    return (
      <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-12 text-center">
        <div className="w-16 h-16 bg-neutral-800 rounded-full flex items-center justify-center mx-auto mb-4">
          <svg className="w-8 h-8 text-neutral-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
          </svg>
        </div>
        <h3 className="text-lg font-semibold text-white mb-2">No Products Yet</h3>
        <p className="text-neutral-500 mb-4">Get started by creating your first product.</p>
        {canManage && (
          <Link href="/products/new" className="text-green-500 hover:text-green-400 transition-colors">
            + Create Product
          </Link>
        )}
      </div>
    )
  }

  return (
    <div className="space-y-4">
      {/* Header with Filter */}
      <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-4">
        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
          <div>
            <h2 className="text-lg font-semibold text-white">All Products</h2>
            <p className="text-sm text-neutral-500">
              {filterName 
                ? `Showing ${filteredAndSortedProducts.length} of ${totalProducts} products`
                : `${totalProducts} product${totalProducts !== 1 ? 's' : ''} registered`
              }
            </p>
          </div>
          <div className="flex items-center gap-4">
            <div className="flex-1 sm:flex-initial sm:w-64">
              <Input
                id="filter-name"
                type="text"
                placeholder="Search products..."
                value={filterName}
                onChange={(e) => setFilterName(e.target.value)}
              />
            </div>
            {canManage && (
              <Link 
                href="/products/new"
                className="px-4 py-2 bg-green-500/20 border border-green-500/30 text-green-400 rounded-lg hover:bg-green-500/30 transition-colors whitespace-nowrap"
              >
                + New Product
              </Link>
            )}
          </div>
        </div>
        {filterName && (
          <div className="mt-4 flex items-center justify-end">
            <button
              onClick={() => setFilterName('')}
              className="text-sm text-green-400 hover:text-green-300 transition-colors"
            >
              Clear Filter
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
                  onClick={() => handleSort('name')}
                >
                  <div className="flex items-center space-x-2">
                    <span>Name</span>
                    <SortIcon field="name" />
                  </div>
                </th>
                <th 
                  className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider cursor-pointer hover:bg-neutral-800/50 transition-colors"
                  onClick={() => handleSort('unit')}
                >
                  <div className="flex items-center space-x-2">
                    <span>Unit</span>
                    <SortIcon field="unit" />
                  </div>
                </th>
                <th 
                  className="px-6 py-3 text-right text-xs font-medium text-neutral-500 uppercase tracking-wider cursor-pointer hover:bg-neutral-800/50 transition-colors"
                  onClick={() => handleSort('price')}
                >
                  <div className="flex items-center justify-end space-x-2">
                    <span>Price</span>
                    <SortIcon field="price" />
                  </div>
                </th>
                <th 
                  className="px-6 py-3 text-left text-xs font-medium text-neutral-500 uppercase tracking-wider cursor-pointer hover:bg-neutral-800/50 transition-colors"
                  onClick={() => handleSort('created_at')}
                >
                  <div className="flex items-center space-x-2">
                    <span>Created</span>
                    <SortIcon field="created_at" />
                  </div>
                </th>
                {canManage && (
                  <th className="px-6 py-3 text-right text-xs font-medium text-neutral-500 uppercase tracking-wider">
                    Actions
                  </th>
                )}
              </tr>
            </thead>
            <tbody className="divide-y divide-neutral-800">
              {filteredAndSortedProducts.length === 0 ? (
                <tr>
                  <td colSpan={canManage ? 5 : 4} className="px-6 py-12 text-center">
                    <div className="text-neutral-500">
                      <svg className="w-12 h-12 mx-auto mb-3 text-neutral-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                      </svg>
                      <p className="text-sm">No products match the search filter</p>
                    </div>
                  </td>
                </tr>
              ) : (
                filteredAndSortedProducts.map((product) => (
                  <tr key={product.id} className="hover:bg-neutral-800/50 transition-colors">
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="flex items-center">
                        <div className="w-10 h-10 bg-green-500/20 rounded-lg flex items-center justify-center mr-3">
                          <svg className="w-5 h-5 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                          </svg>
                        </div>
                        <span className="text-sm font-medium text-white">{product.name}</span>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <span className="text-sm text-neutral-400 bg-neutral-800 px-2 py-1 rounded">{product.unit}</span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-right">
                      <span className="text-sm font-medium text-green-400">
                        $ {(product.price || 0).toFixed(2)}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className="text-sm text-neutral-500">
                        {new Date(product.created_at).toLocaleDateString()}
                      </span>
                    </td>
                    {canManage && (
                      <td className="px-6 py-4 whitespace-nowrap text-right">
                        <div className="flex items-center justify-end space-x-2">
                          <Link
                            href={`/products/${product.id}/edit`}
                            className="px-3 py-1.5 text-xs text-neutral-400 hover:text-white hover:bg-neutral-700 rounded-lg transition-colors"
                          >
                            Edit
                          </Link>
                          <button
                            onClick={() => handleDelete(product.id, product.name)}
                            disabled={deleting === product.id}
                            className="px-3 py-1.5 text-xs text-red-400 hover:text-red-300 hover:bg-red-500/10 rounded-lg transition-colors disabled:opacity-50"
                          >
                            {deleting === product.id ? 'Deleting...' : 'Delete'}
                          </button>
                        </div>
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

import ProtectedRoute from '@/components/auth/ProtectedRoute'
import { getProducts } from '@/lib/queries/products.server'
import Link from 'next/link'
import Button from '@/components/ui/Button'
import { hasRole } from '@/lib/utils/permissions'
import SortableProductsTable from '@/components/products/SortableProductsTable'
import AppHeaderWrapper from '@/components/layout/AppHeader'

export default async function ProductsPage() {
  return (
    <ProtectedRoute>
      <ProductsContent />
    </ProtectedRoute>
  )
}

async function ProductsContent() {
  const products = await getProducts()
  const canManage = await hasRole(['manager', 'owner'])

  return (
    <div className="min-h-screen bg-black">
      <AppHeaderWrapper variant="simple" title="Manage Products" backHref="/" />

      {/* Main Content */}
      <main className="lg:ml-64 max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <SortableProductsTable 
          products={products} 
          canManage={canManage}
          totalProducts={products.length}
        />
      </main>
    </div>
  )
}

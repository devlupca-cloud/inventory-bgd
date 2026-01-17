import ProtectedRoute from '@/components/auth/ProtectedRoute'
import ProductForm from '@/components/products/ProductForm'
import { getProductServer } from '@/lib/queries/products.server'
import { notFound } from 'next/navigation'
import Link from 'next/link'

export default async function EditProductPage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  return (
    <ProtectedRoute requiredRoles={['manager', 'owner']}>
      <EditProductContent params={params} />
    </ProtectedRoute>
  )
}

async function EditProductContent({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const { id } = await params
  const product = await getProductServer(id)

  if (!product) {
    notFound()
  }

  return (
    <div className="min-h-screen bg-black">
      {/* Navigation */}
      <nav className="bg-neutral-900 border-b border-neutral-800">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center space-x-4">
              <Link href="/products" className="flex items-center text-neutral-400 hover:text-white transition-colors">
                <svg className="w-5 h-5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                </svg>
                Back
              </Link>
              <div className="h-6 w-px bg-neutral-700"></div>
              <h1 className="text-xl font-bold text-white">Edit Product</h1>
            </div>
          </div>
        </div>
      </nav>

      {/* Main Content */}
      <main className="max-w-2xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
        <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-6">
          <ProductForm product={product} />
        </div>
      </main>
    </div>
  )
}

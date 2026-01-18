'use client'
import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { useSideMenu } from './SideMenuProvider'

interface AppHeaderProps {
  variant?: 'full' | 'simple'
  title?: string
  backHref?: string
  backLabel?: string
  sticky?: boolean
  canManage?: boolean
  userEmail?: string | null
}

// Helper function to generate breadcrumbs from pathname
function getBreadcrumbs(pathname: string) {
  const paths = pathname.split('/').filter(Boolean)
  const breadcrumbs: Array<{ label: string; href: string }> = [
    { label: 'Dashboard', href: '/' }
  ]

  if (paths.length === 0) {
    return [{ label: 'Dashboard', href: '/' }]
  }

  let currentPath = ''
  paths.forEach((path, index) => {
    currentPath += `/${path}`
    
    // Skip UUIDs and IDs in breadcrumbs
    if (path.match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i)) {
      return
    }

    // Map path segments to readable labels
    const labelMap: Record<string, string> = {
      'inventory': 'Inventory',
      'master': 'Master Warehouse',
      'sites': 'Sites',
      'products': 'Products',
      'purchase-requests': 'Purchase Requests',
      'monthly-list': 'Monthly Purchase List',
      'monthly': 'Monthly Overview',
      'new': 'New',
      'edit': 'Edit',
      'distribute': 'Distribute',
    }

    const label = labelMap[path] || path.charAt(0).toUpperCase() + path.slice(1)
    
    // Only add if it's not the last segment (or if it's a meaningful segment)
    if (index < paths.length - 1 || label !== path) {
      breadcrumbs.push({ label, href: currentPath })
    }
  })

  return breadcrumbs
}

export default function AppHeader({
  variant = 'full',
  title,
  backHref,
  backLabel = 'Back',
  sticky = false,
  canManage = false,
  userEmail = null,
}: AppHeaderProps) {
  const { openMenu } = useSideMenu()
  const pathname = usePathname()
  const breadcrumbs = getBreadcrumbs(pathname)

  if (variant === 'simple') {
    return (
      <>
        <nav className={`bg-neutral-900 border-b border-neutral-800 ${sticky ? 'sticky top-0 z-50' : ''} lg:ml-64`}>
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div className="flex justify-between h-16">
              <div className="flex items-center space-x-4">
                <button
                  onClick={openMenu}
                  className="lg:hidden p-2 text-neutral-400 hover:text-white hover:bg-neutral-800 rounded-lg transition-colors"
                >
                  <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
                  </svg>
                </button>
                {backHref && (
                  <>
                    <Link href={backHref} className="flex items-center text-neutral-400 hover:text-white transition-colors">
                      <svg className="w-5 h-5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                      </svg>
                      {backLabel}
                    </Link>
                    <div className="h-6 w-px bg-neutral-700"></div>
                  </>
                )}
                {title && <h1 className="text-xl font-bold text-white">{title}</h1>}
              </div>
            </div>
          </div>
        </nav>
      </>
    )
  }

  // Full variant with breadcrumbs
  return (
    <>
      <nav className={`bg-neutral-900 border-b border-neutral-800 ${sticky ? 'sticky top-0 z-50' : ''} lg:ml-64`}>
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-16">
            <div className="flex items-center space-x-4">
              <button
                onClick={openMenu}
                className="lg:hidden p-2 text-neutral-400 hover:text-white hover:bg-neutral-800 rounded-lg transition-colors"
              >
                <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
                </svg>
              </button>
              
              {/* Breadcrumbs */}
              <nav className="flex items-center space-x-2 text-sm" aria-label="Breadcrumb">
                {breadcrumbs.map((crumb, index) => (
                  <div key={crumb.href} className="flex items-center space-x-2">
                    {index > 0 && (
                      <svg className="w-4 h-4 text-neutral-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                      </svg>
                    )}
                    {index === breadcrumbs.length - 1 ? (
                      <span className="text-white font-medium">{crumb.label}</span>
                    ) : (
                      <Link 
                        href={crumb.href} 
                        className="text-neutral-400 hover:text-white transition-colors"
                      >
                        {crumb.label}
                      </Link>
                    )}
                  </div>
                ))}
              </nav>
            </div>
          </div>
        </div>
      </nav>
    </>
  )
}

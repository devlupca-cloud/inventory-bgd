'use client'
import { useState, useEffect, useMemo } from 'react'
import Link from 'next/link'
import { usePathname } from 'next/navigation'
import LogoutButton from '@/components/ui/LogoutButton'
import TransferModal from '@/components/modals/TransferModal'

interface SideMenuProps {
  isOpen: boolean
  onClose: () => void
  canManage: boolean
  userEmail?: string | null
}

type MenuItem = {
  title: string
  href?: string
  icon?: React.ReactNode
  items?: Array<{
    title: string
    href: string
    icon: React.ReactNode
  }>
  show?: boolean
}

export default function SideMenu({ isOpen, onClose, canManage, userEmail }: SideMenuProps) {
  const pathname = usePathname()
  const [isDesktop, setIsDesktop] = useState(false)
  const [transferOpen, setTransferOpen] = useState(false)
  
  useEffect(() => {
    const checkDesktop = () => {
      setIsDesktop(window.innerWidth >= 1024)
    }
    checkDesktop()
    window.addEventListener('resize', checkDesktop)
    return () => window.removeEventListener('resize', checkDesktop)
  }, [])
  
  const isActive = (path: string, allMenuItems: MenuItem[] = []) => {
    if (path === '/') {
      return pathname === '/'
    }
    
    // Check if pathname starts with path
    if (pathname.startsWith(path)) {
      // If pathname is exactly the path, it's active
      if (pathname === path) {
        return true
      }
      
      // If pathname starts with path + '/', check if there's a more specific menu item
      // that also matches (e.g., /purchase-requests/monthly-list should not activate /purchase-requests)
      const nextChar = pathname[path.length]
      if (nextChar === '/') {
        // Check if any menu item has a more specific path that matches
        const hasMoreSpecificMatch = allMenuItems.some(item => {
          if (item.href && item.href !== path && item.href.startsWith(path + '/')) {
            return pathname.startsWith(item.href)
          }
          return false
        })
        return !hasMoreSpecificMatch
      }
      return false
    }
    return false
  }
  
  // Only close menu on mobile, not desktop
  const handleLinkClick = () => {
    if (!isDesktop) {
      onClose()
    }
  }
  
  const handleModalClick = (modalType: 'transfer') => {
    if (!isDesktop) {
      onClose()
    }
    if (modalType === 'transfer') setTransferOpen(true)
  }

  const menuItems = useMemo((): MenuItem[] => {
    const items: MenuItem[] = []
    
    // Master Warehouse first (if can manage)
    if (canManage) {
      items.push({
        title: 'Master Warehouse',
        href: '/inventory/master',
        icon: (
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z" />
          </svg>
        ),
      })
    }
    
    items.push(
      {
        title: 'Dashboard',
        href: '/',
        icon: (
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
          </svg>
        ),
      },
    )
    
    if (canManage) {
      items.push({
        title: 'Sites',
        href: '/sites',
        icon: (
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
          </svg>
        ),
      })
    }
    
    items.push(
      {
        title: 'Products',
        href: '/products',
        icon: (
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
          </svg>
        ),
      },
      {
        title: 'Purchase Requests',
        href: '/purchase-requests',
        icon: (
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
          </svg>
        ),
      }
    )
    
    if (canManage) {
      items.push({
        title: 'Monthly Purchase List',
        href: '/purchase-requests/monthly',
        icon: (
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
          </svg>
        ),
      })
    }
    
    if (canManage) {
      items.push({
        title: 'Stock Movements',
        items: [
          {
            title: 'New Request',
            href: '/purchase-requests/new',
            icon: (
              <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
              </svg>
            ),
          },
          {
            title: 'Direct Purchase',
            href: '/purchase-requests/direct',
            icon: (
              <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
              </svg>
            ),
          },
          {
            title: 'Transfer',
            href: '#',
            icon: (
              <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
              </svg>
            ),
          },
        ],
      })
    }
    
    return items
  }, [canManage])

  return (
    <>
      {/* Overlay for mobile */}
      {isOpen && (
        <div
          className="fixed inset-0 bg-black/50 z-40 lg:hidden"
          onClick={onClose}
        />
      )}

      {/* Side Menu */}
      <aside
        className={`
          fixed top-0 left-0 h-full w-64 bg-neutral-900 border-r border-neutral-800 z-50
          transform transition-transform duration-300 ease-in-out
          lg:translate-x-0 lg:z-40
          ${isOpen ? 'translate-x-0' : '-translate-x-full lg:translate-x-0'}
        `}
      >
        <div className="flex flex-col h-full">
          {/* Header */}
          <div className="flex items-center justify-between p-4 border-b border-neutral-800 lg:hidden">
            <Link href="/" className="flex items-center hover:opacity-80 transition-opacity">
              <div className="w-8 h-8 bg-green-500 rounded-lg flex items-center justify-center mr-3">
                <svg className="w-5 h-5 text-black" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                </svg>
              </div>
              <h1 className="text-xl font-bold text-white">BGD Inventory</h1>
            </Link>
            <button
              onClick={onClose}
              className="p-2 text-neutral-400 hover:text-white hover:bg-neutral-800 rounded-lg transition-colors"
            >
              <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>

          {/* Logo for desktop */}
          <div className="hidden lg:flex items-center p-4 border-b border-neutral-800">
            <Link href="/" className="flex items-center hover:opacity-80 transition-opacity">
              <div className="w-8 h-8 bg-green-500 rounded-lg flex items-center justify-center mr-3">
                <svg className="w-5 h-5 text-black" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                </svg>
              </div>
              <h1 className="text-xl font-bold text-white">BGD Inventory</h1>
            </Link>
          </div>

          {/* Menu Items */}
          <nav className="flex-1 overflow-y-auto p-4 space-y-1">
            {menuItems.map((item, index) => {
              if ('items' in item && item.items) {
                // Submenu
                return (
                  <div key={index} className="mb-4">
                    <div className="px-3 py-2 text-xs font-semibold text-neutral-500 uppercase tracking-wider">
                      {item.title}
                    </div>
                    <div className="mt-1 space-y-1">
                      {item.items.map((subItem) => {
                        const isModal = subItem.href === '#'
                        const modalType = subItem.title === 'Transfer' ? 'transfer' : null
                        
                        if (isModal && modalType) {
                          return (
                            <button
                              key={subItem.title}
                              onClick={() => handleModalClick(modalType)}
                              className="w-full flex items-center space-x-3 px-3 py-2 rounded-lg transition-colors text-neutral-400 hover:text-white hover:bg-neutral-800"
                            >
                              {subItem.icon}
                              <span className="text-sm font-medium">{subItem.title}</span>
                            </button>
                          )
                        }
                        
                        return (
                          <Link
                            key={subItem.href}
                            href={subItem.href}
                            onClick={handleLinkClick}
                            className={`
                              flex items-center space-x-3 px-3 py-2 rounded-lg transition-colors
                              ${isActive(subItem.href, menuItems)
                                ? 'bg-green-500/20 text-green-400 border border-green-500/30'
                                : 'text-neutral-400 hover:text-white hover:bg-neutral-800'
                              }
                            `}
                          >
                            {subItem.icon}
                            <span className="text-sm font-medium">{subItem.title}</span>
                          </Link>
                        )
                      })}
                    </div>
                  </div>
                )
              }

              // Regular menu item
              if ('show' in item && !item.show) return null
              if (!item.href) return null

              return (
                <Link
                  key={item.href}
                  href={item.href}
                  onClick={handleLinkClick}
                  className={`
                    flex items-center space-x-3 px-3 py-2 rounded-lg transition-colors
                    ${isActive(item.href, menuItems)
                      ? 'bg-green-500/20 text-green-400 border border-green-500/30'
                      : 'text-neutral-400 hover:text-white hover:bg-neutral-800'
                    }
                  `}
                >
                  {item.icon}
                  <span className="text-sm font-medium">{item.title}</span>
                </Link>
              )
            })}
          </nav>

          {/* Footer */}
          <div className="p-4 border-t border-neutral-800 space-y-3">
            {userEmail && (
              <div className="px-3 py-2 text-xs text-neutral-500 bg-neutral-800 rounded-lg">
                {userEmail}
              </div>
            )}
            <LogoutButton />
          </div>
        </div>
      </aside>
      
      {/* Modals */}
      <TransferModal isOpen={transferOpen} onClose={() => setTransferOpen(false)} />
    </>
  )
}

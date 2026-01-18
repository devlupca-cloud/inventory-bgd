'use client'
import { createContext, useContext, useState, useEffect, ReactNode } from 'react'
import { usePathname } from 'next/navigation'
import SideMenu from './SideMenu'
import { usePermissions } from '@/hooks/usePermissions'

interface SideMenuContextType {
  isOpen: boolean
  openMenu: () => void
  closeMenu: () => void
}

const SideMenuContext = createContext<SideMenuContextType | undefined>(undefined)

export function useSideMenu() {
  const context = useContext(SideMenuContext)
  if (!context) {
    throw new Error('useSideMenu must be used within SideMenuProvider')
  }
  return context
}

export function SideMenuProvider({ children }: { children: ReactNode }) {
  const [isOpen, setIsOpen] = useState(false)
  const [isDesktop, setIsDesktop] = useState(false)
  const pathname = usePathname()
  const { canManage, userEmail } = usePermissions()

  // Don't show side menu on login/signup pages
  const isAuthPage = pathname === '/login' || pathname === '/signup'

  useEffect(() => {
    const checkDesktop = () => {
      const desktop = window.innerWidth >= 1024
      setIsDesktop(desktop)
      if (desktop && !isAuthPage) {
        setIsOpen(true)
      }
    }
    checkDesktop()
    window.addEventListener('resize', checkDesktop)
    return () => window.removeEventListener('resize', checkDesktop)
  }, [isAuthPage])

  const openMenu = () => setIsOpen(true)
  const closeMenu = () => {
    if (!isDesktop) {
      setIsOpen(false)
    }
  }

  return (
    <SideMenuContext.Provider value={{ isOpen, openMenu, closeMenu }}>
      {children}
      {!isAuthPage && (
        <SideMenu isOpen={isOpen} onClose={closeMenu} canManage={canManage} userEmail={userEmail} />
      )}
    </SideMenuContext.Provider>
  )
}

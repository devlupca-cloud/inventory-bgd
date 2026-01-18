'use client'
import { useState, useEffect } from 'react'
import { createClient } from '@/lib/supabase/client'

export function usePermissions() {
  const [canManage, setCanManage] = useState(false)
  const [userEmail, setUserEmail] = useState<string | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function checkPermissions() {
      try {
        const supabase = createClient()
        const { data: { user } } = await supabase.auth.getUser()
        
        if (user) {
          setUserEmail(user.email || null)
          
          // Get user profile to check role
          const { data: profile } = await supabase
            .from('user_profiles')
            .select('role')
            .eq('id', user.id)
            .single()
          
          if (profile && (profile.role === 'manager' || profile.role === 'owner')) {
            setCanManage(true)
          } else {
            setCanManage(false)
          }
        } else {
          setUserEmail(null)
          setCanManage(false)
        }
      } catch (error) {
        console.error('Error checking permissions:', error)
        setCanManage(false)
      } finally {
        setLoading(false)
      }
    }

    checkPermissions()

    // Listen for auth changes
    const supabase = createClient()
    const { data: { subscription } } = supabase.auth.onAuthStateChange(() => {
      checkPermissions()
    })

    return () => {
      subscription.unsubscribe()
    }
  }, [])

  return { canManage, userEmail, loading }
}

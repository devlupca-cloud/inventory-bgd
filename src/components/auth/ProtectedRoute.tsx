import { redirect } from 'next/navigation'
import { createServerSupabaseClient } from '@/lib/supabase/server'
import { ReactNode } from 'react'

interface ProtectedRouteProps {
  children: ReactNode
  requiredRoles?: ('viewer' | 'supervisor' | 'manager' | 'owner')[]
}

export default async function ProtectedRoute({
  children,
  requiredRoles,
}: ProtectedRouteProps) {
  const supabase = await createServerSupabaseClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) {
    redirect('/login')
  }

  if (requiredRoles) {
    const { data: profile } = await supabase
      .from('user_profiles')
      .select('role')
      .eq('id', user.id)
      .single()

    if (!profile || !requiredRoles.includes(profile.role as any)) {
      redirect('/') // Redirect to dashboard if insufficient permissions
    }
  }

  return <>{children}</>
}

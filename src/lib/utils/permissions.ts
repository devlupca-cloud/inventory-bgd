import { createServerSupabaseClient } from '@/lib/supabase/server'

export type UserRole = 'viewer' | 'supervisor' | 'manager' | 'owner'

export interface UserProfile {
  id: string
  email: string
  full_name: string | null
  role: UserRole
}

export async function getUserProfile(): Promise<UserProfile | null> {
  const supabase = await createServerSupabaseClient()
  const { data: { user } } = await supabase.auth.getUser()
  
  if (!user) return null

  const { data: profile } = await supabase
    .from('user_profiles')
    .select('*')
    .eq('id', user.id)
    .single()

  return profile
}

export async function hasRole(requiredRoles: UserRole[]): Promise<boolean> {
  const profile = await getUserProfile()
  if (!profile) return false
  return requiredRoles.includes(profile.role)
}

export async function hasSiteAccess(siteId: string): Promise<boolean> {
  const supabase = await createServerSupabaseClient()
  const profile = await getUserProfile()
  
  if (!profile) return false

  // Managers and owners have access to all sites
  if (profile.role === 'manager' || profile.role === 'owner') {
    return true
  }

  // Viewers have read access to all sites
  if (profile.role === 'viewer') {
    return true
  }

  // Supervisors need to be assigned to the site
  if (profile.role === 'supervisor') {
    const { data } = await supabase
      .from('site_user_roles')
      .select('id')
      .eq('user_id', profile.id)
      .eq('site_id', siteId)
      .single()

    return !!data
  }

  return false
}

export async function canModifySite(siteId: string): Promise<boolean> {
  const profile = await getUserProfile()
  if (!profile) return false

  if (profile.role === 'manager' || profile.role === 'owner') {
    return true
  }

  if (profile.role === 'supervisor') {
    const supabase = await createServerSupabaseClient()
    const { data } = await supabase
      .from('site_user_roles')
      .select('id')
      .eq('user_id', profile.id)
      .eq('site_id', siteId)
      .single()

    return !!data
  }

  return false
}

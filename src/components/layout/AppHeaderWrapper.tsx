import { createServerSupabaseClient } from '@/lib/supabase/server'
import { hasRole } from '@/lib/utils/permissions'
import AppHeader from './AppHeader'

interface AppHeaderWrapperProps {
  variant?: 'full' | 'simple'
  title?: string
  backHref?: string
  backLabel?: string
  sticky?: boolean
}

export default async function AppHeaderWrapper({
  variant = 'full',
  title,
  backHref,
  backLabel = 'Back',
  sticky = false,
}: AppHeaderWrapperProps) {
  const supabase = await createServerSupabaseClient()
  const { data: { user } } = await supabase.auth.getUser()
  const canManage = await hasRole(['manager', 'owner'])

  return (
    <AppHeader
      variant={variant}
      title={title}
      backHref={backHref}
      backLabel={backLabel}
      sticky={sticky}
      canManage={canManage}
      userEmail={user?.email || null}
    />
  )
}

'use client'
import { APP_VERSION } from '@/lib/version'

export default function VersionBadge() {
  return (
    <div className="flex items-center gap-2 px-3 py-1.5 bg-neutral-800/50 border border-neutral-700 rounded-lg">
      <span className="text-xs text-neutral-500">v</span>
      <span className="text-xs font-medium text-neutral-400">{APP_VERSION}</span>
    </div>
  )
}

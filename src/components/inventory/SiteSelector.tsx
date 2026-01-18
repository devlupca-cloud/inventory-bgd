'use client'
import { useEffect, useState } from 'react'
import { getSites, Site } from '@/lib/queries/sites'
import Select from '@/components/ui/Select'

interface SiteSelectorProps {
  value?: string
  onChange: (siteId: string) => void
  label?: string
  disabled?: boolean
}

export default function SiteSelector({ value, onChange, label = 'Site', disabled = false }: SiteSelectorProps) {
  const [sites, setSites] = useState<Site[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function loadSites() {
      try {
        const data = await getSites()
        // Exclude master site from regular site selection (master is managed separately)
        setSites(data.filter(site => !site.is_master))
      } catch (error) {
        console.error('Error loading sites:', error)
      } finally {
        setLoading(false)
      }
    }
    loadSites()
  }, [])

  if (loading) {
    return (
      <div className="text-sm text-neutral-500">Loading sites...</div>
    )
  }

  return (
    <Select
      label={label}
      value={value || ''}
      onChange={(e) => onChange(e.target.value)}
      disabled={disabled}
    >
      <option value="">Select a site</option>
      {sites.map((site) => (
        <option key={site.id} value={site.id}>
          {site.name}
        </option>
      ))}
    </Select>
  )
}

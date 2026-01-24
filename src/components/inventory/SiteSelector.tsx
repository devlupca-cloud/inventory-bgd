'use client'
import { useEffect, useState, useId } from 'react'
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
  const selectId = useId()

  useEffect(() => {
    async function loadSites() {
      try {
        const data = await getSites()
        // Exclude master site from regular site selection (master is managed separately)
        const filteredSites = data.filter(site => !site.is_master)
        setSites(filteredSites)
        if (filteredSites.length === 0) {
          console.warn('No sites available for selection')
        }
      } catch (error) {
        console.error('Error loading sites:', error)
        setSites([])
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
      id={selectId}
      label={label}
      value={value || ''}
      onChange={(e) => onChange(e.target.value)}
      disabled={disabled}
    >
      <option value="">No site (general request)</option>
      {sites.map((site) => (
        <option key={site.id} value={site.id}>
          {site.name}
        </option>
      ))}
    </Select>
  )
}

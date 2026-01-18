'use client'
import { useEffect, useState } from 'react'
import { getSites, getMasterSite, Site } from '@/lib/queries/sites'
import Select from '@/components/ui/Select'

interface MasterSiteSelectorProps {
  value?: string
  onChange: (siteId: string) => void
  label?: string
  disabled?: boolean
  includeMaster?: boolean
}

export default function MasterSiteSelector({ 
  value, 
  onChange, 
  label = 'Site', 
  disabled = false,
  includeMaster = false 
}: MasterSiteSelectorProps) {
  const [sites, setSites] = useState<Site[]>([])
  const [masterSite, setMasterSite] = useState<Site | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function loadSites() {
      try {
        const [sitesData, master] = await Promise.all([
          getSites(),
          includeMaster ? getMasterSite() : Promise.resolve(null)
        ])
        // Exclude master from regular sites if not including it
        const regularSites = includeMaster 
          ? sitesData.filter(site => !site.is_master)
          : sitesData.filter(site => !site.is_master)
        
        setSites(regularSites)
        setMasterSite(master)
      } catch (error) {
        console.error('Error loading sites:', error)
      } finally {
        setLoading(false)
      }
    }
    loadSites()
  }, [includeMaster])

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
      {includeMaster && masterSite && (
        <option value={masterSite.id}>
          {masterSite.name} (Master)
        </option>
      )}
      {sites.map((site) => (
        <option key={site.id} value={site.id}>
          {site.name}
        </option>
      ))}
    </Select>
  )
}

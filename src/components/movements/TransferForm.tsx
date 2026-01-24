'use client'
import { useState, useEffect } from 'react'
import { transferBetweenSites } from '@/lib/rpc/inventory'
import { getSiteInventory, SiteInventoryItem } from '@/lib/queries/inventory'
import { getMasterSite, getSites } from '@/lib/queries/sites'
import Select from '@/components/ui/Select'
import Input from '@/components/ui/Input'
import Button from '@/components/ui/Button'
import { useRouter } from 'next/navigation'

interface TransferFormProps {
  initialToSiteId?: string
  initialProductId?: string
  onClose?: () => void
}

export default function TransferForm({ initialToSiteId = '', initialProductId = '', onClose }: TransferFormProps) {
  const [masterSiteId, setMasterSiteId] = useState<string>('')
  const [masterSiteName, setMasterSiteName] = useState<string>('Master Warehouse')
  const [toSiteId, setToSiteId] = useState(initialToSiteId)
  const [notes, setNotes] = useState('')
  const [destinationSites, setDestinationSites] = useState<Array<{ id: string; name: string }>>([])
  const [masterInventory, setMasterInventory] = useState<SiteInventoryItem[]>([])
  const [search, setSearch] = useState('')
  const [sendPlan, setSendPlan] = useState<Record<string, number | undefined>>({})
  const [loadingInventory, setLoadingInventory] = useState(false)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState(false)
  const router = useRouter()

  useEffect(() => {
    loadMasterAndSites()
    if (initialToSiteId) setToSiteId(initialToSiteId)
    // initialProductId is ignored in the new UX (list-driven)
  }, [initialToSiteId, initialProductId])

  const loadMasterAndSites = async () => {
    try {
      const [master, sites] = await Promise.all([getMasterSite(), getSites()])
      if (master?.id) {
        setMasterSiteId(master.id)
        setMasterSiteName(master.name || 'Master Warehouse')
      }
      setDestinationSites(sites.filter(s => !s.is_master).map(s => ({ id: s.id, name: s.name })))
    } catch (err) {
      console.error('Error loading sites:', err)
    }
  }

  const loadMasterInventory = async (masterId: string) => {
    setLoadingInventory(true)
    try {
      const inv = await getSiteInventory(masterId)
      // Only show products that actually exist in Master
      setMasterInventory(inv.filter((row) => (row.quantity_on_hand || 0) > 0))
    } catch (err) {
      console.error('Error loading master inventory:', err)
      setMasterInventory([])
    } finally {
      setLoadingInventory(false)
    }
  }

  useEffect(() => {
    if (masterSiteId) {
      loadMasterInventory(masterSiteId)
    }
  }, [masterSiteId])

  const setQty = (productId: string, raw: string, max: number) => {
    const parsed = raw === '' ? 0 : parseInt(raw, 10)
    const value = Number.isFinite(parsed) ? parsed : 0
    const clamped = Math.min(Math.max(0, value), max)
    setSendPlan(prev => ({
      ...prev,
      [productId]: clamped > 0 ? clamped : undefined,
    }))
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError('')
    setSuccess(false)

    if (!masterSiteId) {
      setError('Master warehouse not found')
      setLoading(false)
      return
    }

    if (!toSiteId) {
      setError('Please select a destination site')
      setLoading(false)
      return
    }

    const transfers = Object.entries(sendPlan)
      .filter(([_, qty]) => !!qty && qty > 0)
      .map(([productId, qty]) => ({ productId, quantity: qty as number }))

    if (transfers.length === 0) {
      setError('Please enter quantities for at least one product')
      setLoading(false)
      return
    }

    try {
      // Validate against Master inventory (integer-only)
      const availability = new Map(masterInventory.map((row) => [row.product_id, Math.floor(row.quantity_on_hand || 0)]))
      for (const t of transfers) {
        const available = availability.get(t.productId) || 0
        if (!Number.isInteger(t.quantity) || t.quantity <= 0) {
          throw new Error('All quantities must be whole numbers greater than 0')
        }
        if (t.quantity > available) {
          const name = masterInventory.find(r => r.product_id === t.productId)?.product?.name || 'product'
          throw new Error(`Cannot send more than available for ${name}. Available: ${available}`)
        }
      }

      for (const t of transfers) {
        const result = await transferBetweenSites(
          masterSiteId,
          toSiteId,
          t.productId,
          t.quantity,
          // Tag as "master stock" so site monthly report can split origin
          `Master send${notes ? ` - ${notes}` : ''}`
        )

        if (!result.success) {
          throw new Error(result.message || 'Failed to send items')
        }
      }

      setSuccess(true)
      setSendPlan({})
      setTimeout(() => {
        if (onClose) {
          onClose()
          router.refresh()
        } else {
          router.push('/inventory/master')
          router.refresh()
        }
      }, 1200)
    } catch (err: any) {
      setError(err.message || 'An error occurred')
    } finally {
      setLoading(false)
    }
  }

  const filteredInventory = masterInventory.filter((row) => {
    const q = search.trim().toLowerCase()
    if (!q) return true
    const name = row.product?.name?.toLowerCase() || ''
    const unit = row.product?.unit?.toLowerCase() || ''
    return name.includes(q) || unit.includes(q)
  })

  return (
    <form onSubmit={handleSubmit} className="space-y-5">
      <div className="bg-neutral-800/40 border border-neutral-700 rounded-lg px-4 py-3">
        <p className="text-sm text-neutral-400">
          <span className="text-neutral-500">From:</span>{' '}
          <span className="text-white font-medium">{masterSiteName}</span>{' '}
          <span className="text-xs text-neutral-500">(Master)</span>
        </p>
        <p className="text-xs text-neutral-500 mt-1">
          This action sends items from the Master Warehouse to a site (no site-to-site transfers).
        </p>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        <Select
          label="To Site"
          value={toSiteId}
          onChange={(e) => setToSiteId(e.target.value)}
          required
        >
          <option value="">Select a site</option>
          {destinationSites.map((site) => (
            <option key={site.id} value={site.id}>
              {site.name}
            </option>
          ))}
        </Select>

        <Input
          label="Search products"
          type="text"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          placeholder="Type to filter..."
        />
      </div>

      <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-4">
        <div className="flex items-center justify-between mb-3">
          <h4 className="text-white font-medium">Available in Master</h4>
          <p className="text-xs text-neutral-500">
            {filteredInventory.length} products
          </p>
        </div>

        {loadingInventory ? (
          <div className="py-8 text-center text-sm text-neutral-500">Loading inventory...</div>
        ) : filteredInventory.length === 0 ? (
          <div className="py-8 text-center text-sm text-neutral-500">No products found.</div>
        ) : (
          <div className="space-y-3 max-h-80 overflow-y-auto pr-1">
            {filteredInventory.map((row) => {
              const available = Math.floor(row.quantity_on_hand || 0)
              const current = sendPlan[row.product_id] || 0
              return (
                <div key={row.product_id} className="border border-neutral-800 rounded-lg p-3">
                  <div className="flex items-start justify-between">
                    <div>
                      <p className="text-white font-medium">{row.product.name}</p>
                      <p className="text-xs text-neutral-500 mt-1">
                        Available: <span className="text-green-400 font-semibold">{available.toLocaleString()}</span> {row.product.unit}
                      </p>
                    </div>
                    <div className="w-32">
                      <Input
                        type="number"
                        min="0"
                        step="1"
                        max={available}
                        value={current || ''}
                        onChange={(e) => setQty(row.product_id, e.target.value, available)}
                        placeholder="0"
                        disabled={!toSiteId || available <= 0}
                      />
                    </div>
                  </div>
                </div>
              )
            })}
          </div>
        )}
      </div>

      <Input
        label="Notes (optional)"
        type="text"
        value={notes}
        onChange={(e) => setNotes(e.target.value)}
        placeholder="Add any notes..."
      />

      {error && (
        <div className="bg-red-500/20 border border-red-500/30 text-red-400 px-4 py-3 rounded-lg text-sm">
          {error}
        </div>
      )}

      {success && (
        <div className="bg-green-500/20 border border-green-500/30 text-green-400 px-4 py-3 rounded-lg text-sm">
          Sent successfully!{onClose ? '' : ' Redirecting...'}
        </div>
      )}

      <Button type="submit" disabled={loading || !masterSiteId || !toSiteId} className="w-full">
        {loading ? 'Sending...' : 'Send Items'}
      </Button>
    </form>
  )
}

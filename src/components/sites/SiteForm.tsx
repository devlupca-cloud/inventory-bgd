'use client'
import { useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { Site } from '@/lib/queries/sites'
import Input from '@/components/ui/Input'
import Button from '@/components/ui/Button'
import { useRouter } from 'next/navigation'

interface SiteFormProps {
  site?: Site
}

export default function SiteForm({ site }: SiteFormProps) {
  const [name, setName] = useState(site?.name || '')
  const [address, setAddress] = useState(site?.address || '')
  const [supervisorName, setSupervisorName] = useState(site?.supervisor_name || '')
  const [supervisorPhone, setSupervisorPhone] = useState(site?.supervisor_phone || '')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState(false)
  const supabase = createClient()
  const router = useRouter()
  const isEditing = !!site

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError('')
    setSuccess(false)

    if (!name.trim()) {
      setError('Site name is required')
      setLoading(false)
      return
    }

    try {
      if (isEditing) {
        const { error: updateError } = await supabase
          .from('sites')
          // @ts-expect-error - Supabase type inference issue
          .update({
            name: name.trim(),
            address: address.trim() || null,
            supervisor_name: supervisorName.trim() || null,
            supervisor_phone: supervisorPhone.trim() || null,
          })
          .eq('id', site.id)

        if (updateError) throw updateError
      } else {
        const { error: insertError } = await supabase
          .from('sites')
          // @ts-expect-error - Supabase type inference issue
          .insert({
            name: name.trim(),
            address: address.trim() || null,
            supervisor_name: supervisorName.trim() || null,
            supervisor_phone: supervisorPhone.trim() || null,
          })

        if (insertError) throw insertError
      }

      setSuccess(true)
      setTimeout(() => {
        router.push('/sites')
        router.refresh()
      }, 1000)
    } catch (err: any) {
      setError(err.message || 'An error occurred')
    } finally {
      setLoading(false)
    }
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-5">
      <Input
        label="Site Name"
        type="text"
        value={name}
        onChange={(e) => setName(e.target.value)}
        placeholder="e.g., Downtown Office"
        required
      />

      <Input
        label="Address (optional)"
        type="text"
        value={address}
        onChange={(e) => setAddress(e.target.value)}
        placeholder="e.g., 123 Main St, City, State 12345"
      />

      <div className="border-t border-neutral-800 pt-5">
        <h3 className="text-sm font-medium text-neutral-300 mb-4">Supervisor Information</h3>
        <div className="space-y-4">
          <Input
            label="Supervisor Name (optional)"
            type="text"
            value={supervisorName}
            onChange={(e) => setSupervisorName(e.target.value)}
            placeholder="e.g., João Silva"
          />

          <Input
            label="Supervisor Phone (optional)"
            type="tel"
            value={supervisorPhone}
            onChange={(e) => setSupervisorPhone(e.target.value)}
            placeholder="e.g., +5511999999999"
          />
        </div>
      </div>

      {error && (
        <div className="bg-red-500/20 border border-red-500/30 text-red-400 px-4 py-3 rounded-lg text-sm">
          {error}
        </div>
      )}

      {success && (
        <div className="bg-green-500/20 border border-green-500/30 text-green-400 px-4 py-3 rounded-lg text-sm">
          Site {isEditing ? 'updated' : 'created'} successfully! Redirecting...
        </div>
      )}

      <div className="flex space-x-4">
        <Button type="submit" disabled={loading}>
          {loading ? 'Saving...' : isEditing ? 'Update Site' : 'Create Site'}
        </Button>
        <Button
          type="button"
          variant="secondary"
          onClick={() => router.push('/sites')}
        >
          Cancel
        </Button>
      </div>
    </form>
  )
}

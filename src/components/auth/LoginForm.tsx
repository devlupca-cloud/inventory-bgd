'use client'
import { useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { useRouter } from 'next/navigation'
import Button from '@/components/ui/Button'
import Input from '@/components/ui/Input'

export default function LoginForm() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [loading, setLoading] = useState(false)
  const [message, setMessage] = useState('')
  const [mode, setMode] = useState<'magic' | 'password'>('password')
  const supabase = createClient()
  const router = useRouter()

  const handleMagicLink = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setMessage('')
    
    const { error } = await supabase.auth.signInWithOtp({
      email,
      options: {
        emailRedirectTo: `${window.location.origin}/api/auth/callback`,
      },
    })
    
    if (error) {
      setMessage(error.message)
    } else {
      setMessage('Check your email for the login link!')
    }
    setLoading(false)
  }

  const handlePasswordLogin = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setMessage('')
    
    const { error } = await supabase.auth.signInWithPassword({
      email,
      password,
    })
    
    if (error) {
      setMessage(error.message)
    } else {
      router.push('/inventory')
      router.refresh()
    }
    setLoading(false)
  }

  return (
    <div className="flex min-h-screen items-center justify-center bg-black px-4">
      <div className="w-full max-w-md space-y-8">
        {/* Logo/Header */}
        <div className="text-center">
          <div className="mx-auto w-16 h-16 bg-green-500 rounded-2xl flex items-center justify-center mb-6">
            <svg className="w-10 h-10 text-black" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
            </svg>
          </div>
          <h2 className="text-3xl font-bold text-white">
            BGD Inventory
          </h2>
          <p className="mt-2 text-neutral-400">
            Sign in to your account
          </p>
        </div>

        {/* Card */}
        <div className="bg-neutral-900 border border-neutral-800 rounded-2xl p-8">
          {/* Toggle */}
          <div className="flex rounded-lg bg-neutral-800 p-1 mb-6">
            <button
              type="button"
              onClick={() => setMode('password')}
              className={`flex-1 py-2 text-sm font-medium rounded-md transition-all ${
                mode === 'password'
                  ? 'bg-green-500 text-black'
                  : 'text-neutral-400 hover:text-white'
              }`}
            >
              Password
            </button>
            <button
              type="button"
              onClick={() => setMode('magic')}
              className={`flex-1 py-2 text-sm font-medium rounded-md transition-all ${
                mode === 'magic'
                  ? 'bg-green-500 text-black'
                  : 'text-neutral-400 hover:text-white'
              }`}
            >
              Magic Link
            </button>
          </div>

          {mode === 'magic' ? (
            <form className="space-y-5" onSubmit={handleMagicLink}>
              <Input
                id="email"
                name="email"
                type="email"
                autoComplete="email"
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                label="Email address"
                placeholder="you@example.com"
              />

              <Button type="submit" disabled={loading} className="w-full">
                {loading ? 'Sending...' : 'Send Magic Link'}
              </Button>
            </form>
          ) : (
            <form className="space-y-5" onSubmit={handlePasswordLogin}>
              <Input
                id="email-password"
                name="email"
                type="email"
                autoComplete="email"
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                label="Email address"
                placeholder="you@example.com"
              />
              
              <Input
                id="password"
                name="password"
                type="password"
                autoComplete="current-password"
                required
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                label="Password"
                placeholder="••••••••"
              />

              <Button type="submit" disabled={loading} className="w-full">
                {loading ? 'Signing in...' : 'Sign in'}
              </Button>
            </form>
          )}

          {message && (
            <div
              className={`mt-4 rounded-lg p-4 text-sm ${
                message.includes('Check your email')
                  ? 'bg-green-500/20 text-green-400 border border-green-500/30'
                  : 'bg-red-500/20 text-red-400 border border-red-500/30'
              }`}
            >
              {message}
            </div>
          )}
        </div>

        <p className="text-center text-sm text-neutral-500">
          BGD Solutions © {new Date().getFullYear()}
        </p>
      </div>
    </div>
  )
}

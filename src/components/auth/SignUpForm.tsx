'use client'
import { useState } from 'react'
import { createClient } from '@/lib/supabase/client'
import { useRouter } from 'next/navigation'
import Button from '@/components/ui/Button'
import Input from '@/components/ui/Input'
import Link from 'next/link'

export default function SignUpForm() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [confirmPassword, setConfirmPassword] = useState('')
  const [fullName, setFullName] = useState('')
  const [loading, setLoading] = useState(false)
  const [message, setMessage] = useState('')
  const supabase = createClient()
  const router = useRouter()

  const handleSignUp = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setMessage('')

    // Validation
    if (password !== confirmPassword) {
      setMessage('Passwords do not match')
      setLoading(false)
      return
    }

    if (password.length < 6) {
      setMessage('Password must be at least 6 characters')
      setLoading(false)
      return
    }

    try {
      // Sign up user
      const { data, error } = await supabase.auth.signUp({
        email,
        password,
        options: {
          data: {
            full_name: fullName || null,
          },
          emailRedirectTo: `${window.location.origin}/api/auth/callback`,
        },
      })

      if (error) {
        setMessage(error.message)
      } else if (data.user) {
        setMessage('Account created! Please check your email to verify your account before signing in.')
        // Clear form
        setEmail('')
        setPassword('')
        setConfirmPassword('')
        setFullName('')
      }
    } catch (err: any) {
      setMessage(err.message || 'An error occurred')
    } finally {
      setLoading(false)
    }
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
            Create your account
          </p>
        </div>

        {/* Card */}
        <div className="bg-neutral-900 border border-neutral-800 rounded-2xl p-8">
          <form className="space-y-5" onSubmit={handleSignUp}>
            <Input
              id="fullName"
              name="fullName"
              type="text"
              autoComplete="name"
              value={fullName}
              onChange={(e) => setFullName(e.target.value)}
              label="Full Name (optional)"
              placeholder="John Doe"
            />

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
            
            <Input
              id="password"
              name="password"
              type="password"
              autoComplete="new-password"
              required
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              label="Password"
              placeholder="••••••••"
            />

            <Input
              id="confirmPassword"
              name="confirmPassword"
              type="password"
              autoComplete="new-password"
              required
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              label="Confirm Password"
              placeholder="••••••••"
            />

            <Button type="submit" disabled={loading} className="w-full">
              {loading ? 'Creating account...' : 'Create Account'}
            </Button>
          </form>

          {message && (
            <div
              className={`mt-4 rounded-lg p-4 text-sm ${
                message.includes('Account created') || message.includes('check your email')
                  ? 'bg-green-500/20 text-green-400 border border-green-500/30'
                  : 'bg-red-500/20 text-red-400 border border-red-500/30'
              }`}
            >
              {message}
            </div>
          )}

          <div className="mt-6 text-center">
            <p className="text-sm text-neutral-400">
              Already have an account?{' '}
              <Link href="/login" className="text-green-400 hover:text-green-300 transition-colors">
                Sign in
              </Link>
            </p>
          </div>
        </div>

        <p className="text-center text-sm text-neutral-500">
          BGD Solutions © {new Date().getFullYear()}
        </p>
      </div>
    </div>
  )
}

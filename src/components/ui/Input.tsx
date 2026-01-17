import { InputHTMLAttributes } from 'react'

interface InputProps extends InputHTMLAttributes<HTMLInputElement> {
  label?: string
  error?: string
}

export default function Input({ label, error, className = '', ...props }: InputProps) {
  return (
    <div className="w-full">
      {label && (
        <label htmlFor={props.id} className="block text-sm font-medium text-neutral-300 mb-1.5">
          {label}
        </label>
      )}
      <input
        className={`block w-full rounded-lg bg-neutral-900 border border-neutral-700 px-4 py-2.5 text-neutral-100 placeholder-neutral-500 focus:border-green-500 focus:ring-1 focus:ring-green-500 focus:outline-none transition-colors ${error ? 'border-red-500' : ''} ${className}`}
        {...props}
      />
      {error && (
        <p className="mt-1.5 text-sm text-red-400">{error}</p>
      )}
    </div>
  )
}

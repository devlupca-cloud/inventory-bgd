import { SelectHTMLAttributes, ReactNode } from 'react'

interface SelectProps extends SelectHTMLAttributes<HTMLSelectElement> {
  label?: string
  error?: string
  children: ReactNode
}

export default function Select({ label, error, className = '', children, ...props }: SelectProps) {
  return (
    <div className="w-full">
      {label && (
        <label htmlFor={props.id} className="block text-sm font-medium text-neutral-300 mb-1.5">
          {label}
        </label>
      )}
      <select
        className={`block w-full rounded-lg bg-neutral-900 border border-neutral-700 px-4 py-2.5 text-neutral-100 focus:border-green-500 focus:ring-1 focus:ring-green-500 focus:outline-none transition-colors appearance-none cursor-pointer ${error ? 'border-red-500' : ''} ${className}`}
        {...props}
      >
        {children}
      </select>
      {error && (
        <p className="mt-1.5 text-sm text-red-400">{error}</p>
      )}
    </div>
  )
}

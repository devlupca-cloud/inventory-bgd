import { SelectHTMLAttributes, ReactNode } from 'react'

interface SelectProps extends SelectHTMLAttributes<HTMLSelectElement> {
  label?: string
  error?: string
  children: ReactNode
}

export default function Select({ label, error, className = '', children, ...props }: SelectProps) {
  return (
    <div className="w-full relative">
      {label && (
        <label htmlFor={props.id} className="block text-sm font-medium text-neutral-300 mb-1.5">
          {label}
        </label>
      )}
      <div className="relative">
        <select
          className={`block w-full rounded-lg bg-neutral-900 border border-neutral-700 px-4 py-2.5 pr-10 text-neutral-100 focus:border-green-500 focus:ring-1 focus:ring-green-500 focus:outline-none transition-colors appearance-none cursor-pointer ${error ? 'border-red-500' : ''} ${className}`}
          style={{ WebkitAppearance: 'none', MozAppearance: 'none', position: 'relative', zIndex: 1 }}
          {...props}
        >
          {children}
        </select>
        <div className="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none" style={{ zIndex: 0 }}>
          <svg className="w-5 h-5 text-neutral-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
          </svg>
        </div>
      </div>
      {error && (
        <p className="mt-1.5 text-sm text-red-400">{error}</p>
      )}
    </div>
  )
}

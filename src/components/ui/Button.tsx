import { ButtonHTMLAttributes, ReactNode } from 'react'

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  children: ReactNode
  variant?: 'primary' | 'secondary' | 'danger' | 'ghost'
  size?: 'sm' | 'md' | 'lg'
}

export default function Button({ 
  children, 
  variant = 'primary', 
  size = 'md',
  className = '', 
  ...props 
}: ButtonProps) {
  const baseClasses = 'font-medium rounded-lg transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-black disabled:opacity-50 disabled:cursor-not-allowed'
  
  const variantClasses = {
    primary: 'bg-green-500 text-black hover:bg-green-400 focus:ring-green-500',
    secondary: 'bg-neutral-800 text-neutral-100 hover:bg-neutral-700 border border-neutral-700 focus:ring-neutral-500',
    danger: 'bg-red-600 text-white hover:bg-red-500 focus:ring-red-500',
    ghost: 'bg-transparent text-neutral-300 hover:bg-neutral-800 hover:text-white focus:ring-neutral-500',
  }

  const sizeClasses = {
    sm: 'px-3 py-1.5 text-sm',
    md: 'px-4 py-2 text-sm',
    lg: 'px-6 py-3 text-base',
  }

  return (
    <button
      className={`${baseClasses} ${variantClasses[variant]} ${sizeClasses[size]} ${className}`}
      {...props}
    >
      {children}
    </button>
  )
}

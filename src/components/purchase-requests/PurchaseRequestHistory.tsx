'use client'

function formatDate(dateString: string): string {
  const date = new Date(dateString)
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  const month = months[date.getMonth()]
  const day = date.getDate()
  const year = date.getFullYear()
  const hours = date.getHours().toString().padStart(2, '0')
  const minutes = date.getMinutes().toString().padStart(2, '0')
  return `${month} ${day}, ${year} ${hours}:${minutes}`
}

interface PurchaseRequestHistoryProps {
  request: {
    status: string
    created_at: string
    updated_at: string
    approved_at: string | null
    requested_by_user: {
      email: string
      full_name: string | null
    } | null
    approved_by_user?: {
      email: string
      full_name: string | null
    } | null
  }
}

export default function PurchaseRequestHistory({ request }: PurchaseRequestHistoryProps) {
  const historyItems = []

  // Created
  historyItems.push({
    action: 'Created',
    description: `Request created by ${request.requested_by_user?.full_name || request.requested_by_user?.email || 'Unknown'}`,
    timestamp: request.created_at,
    icon: (
      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
      </svg>
    ),
    color: 'text-blue-400',
    bgColor: 'bg-blue-500/20',
  })

  // Status changes
  if (request.status === 'submitted') {
    historyItems.push({
      action: 'Submitted',
      description: `Submitted for approval by ${request.requested_by_user?.full_name || request.requested_by_user?.email || 'Unknown'}`,
      timestamp: request.updated_at,
      icon: (
        <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
        </svg>
      ),
      color: 'text-amber-400',
      bgColor: 'bg-amber-500/20',
    })
  }

  if (request.status === 'approved' || request.status === 'fulfilled' || request.status === 'partially_fulfilled') {
    historyItems.push({
      action: 'Approved',
      description: `Approved by ${request.approved_by_user?.full_name || request.approved_by_user?.email || 'Unknown'}`,
      timestamp: request.approved_at || request.updated_at,
      icon: (
        <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
        </svg>
      ),
      color: 'text-green-400',
      bgColor: 'bg-green-500/20',
    })
  }

  if (request.status === 'rejected') {
    historyItems.push({
      action: 'Rejected',
      description: `Rejected by ${request.approved_by_user?.full_name || request.approved_by_user?.email || 'Unknown'}`,
      timestamp: request.updated_at,
      icon: (
        <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
        </svg>
      ),
      color: 'text-red-400',
      bgColor: 'bg-red-500/20',
    })
  }

  if (request.status === 'fulfilled' || request.status === 'partially_fulfilled') {
    historyItems.push({
      action: request.status === 'fulfilled' ? 'Fulfilled' : 'Partially Fulfilled',
      description: request.status === 'fulfilled' 
        ? 'All items have been received and added to inventory'
        : 'Some items have been received and added to inventory',
      timestamp: request.updated_at,
      icon: (
        <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
        </svg>
      ),
      color: 'text-green-400',
      bgColor: 'bg-green-500/20',
    })
  }

  // Sort by timestamp (most recent first)
  historyItems.sort((a, b) => new Date(b.timestamp).getTime() - new Date(a.timestamp).getTime())

  return (
    <div className="bg-neutral-900 border border-neutral-800 rounded-xl p-6">
      <h3 className="text-lg font-semibold text-white mb-4">Action History</h3>
      <div className="space-y-4">
        {historyItems.map((item, index) => (
          <div key={index} className="flex items-start space-x-4">
            <div className={`flex-shrink-0 w-10 h-10 ${item.bgColor} rounded-lg flex items-center justify-center ${item.color}`}>
              {item.icon}
            </div>
            <div className="flex-1 min-w-0">
              <div className="flex items-center justify-between">
                <p className={`text-sm font-medium ${item.color}`}>{item.action}</p>
                <p className="text-xs text-neutral-500">
                  {formatDate(item.timestamp)}
                </p>
              </div>
              <p className="text-sm text-neutral-400 mt-1">{item.description}</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}

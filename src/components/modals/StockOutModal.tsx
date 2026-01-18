'use client'
import Dialog from '@/components/ui/Dialog'
import RegisterOutForm from '@/components/movements/RegisterOutForm'

interface StockOutModalProps {
  isOpen: boolean
  onClose: () => void
  initialSiteId?: string
  initialProductId?: string
}

export default function StockOutModal({ isOpen, onClose, initialSiteId, initialProductId }: StockOutModalProps) {
  return (
    <Dialog isOpen={isOpen} onClose={onClose} title="Stock OUT" size="lg">
      <RegisterOutForm 
        initialSiteId={initialSiteId} 
        initialProductId={initialProductId}
        onClose={onClose}
      />
    </Dialog>
  )
}

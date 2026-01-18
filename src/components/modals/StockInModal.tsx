'use client'
import Dialog from '@/components/ui/Dialog'
import RegisterInForm from '@/components/movements/RegisterInForm'

interface StockInModalProps {
  isOpen: boolean
  onClose: () => void
  initialSiteId?: string
  initialProductId?: string
}

export default function StockInModal({ isOpen, onClose, initialSiteId, initialProductId }: StockInModalProps) {
  return (
    <Dialog isOpen={isOpen} onClose={onClose} title="Stock IN" size="lg">
      <RegisterInForm 
        initialSiteId={initialSiteId} 
        initialProductId={initialProductId}
        onClose={onClose}
      />
    </Dialog>
  )
}

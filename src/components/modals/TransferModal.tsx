'use client'
import Dialog from '@/components/ui/Dialog'
import TransferForm from '@/components/movements/TransferForm'

interface TransferModalProps {
  isOpen: boolean
  onClose: () => void
  initialToSiteId?: string
  initialProductId?: string
}

export default function TransferModal({ isOpen, onClose, initialToSiteId, initialProductId }: TransferModalProps) {
  return (
    <Dialog isOpen={isOpen} onClose={onClose} title="Send to Site" size="lg">
      <TransferForm 
        initialToSiteId={initialToSiteId} 
        initialProductId={initialProductId}
        onClose={onClose}
      />
    </Dialog>
  )
}

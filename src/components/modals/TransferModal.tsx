'use client'
import Dialog from '@/components/ui/Dialog'
import TransferForm from '@/components/movements/TransferForm'

interface TransferModalProps {
  isOpen: boolean
  onClose: () => void
  initialFromSiteId?: string
  initialProductId?: string
}

export default function TransferModal({ isOpen, onClose, initialFromSiteId, initialProductId }: TransferModalProps) {
  return (
    <Dialog isOpen={isOpen} onClose={onClose} title="Transfer Stock" size="lg">
      <TransferForm 
        initialFromSiteId={initialFromSiteId} 
        initialProductId={initialProductId}
        onClose={onClose}
      />
    </Dialog>
  )
}

import { createServerSupabaseClient } from '@/lib/supabase/server'

export type ReceiptSource = 'purchase_request' | 'master_stock'

export interface SiteReceiptRow {
  created_at: string
  product_id: string
  product_name: string
  product_unit: string
  quantity: number
  source: ReceiptSource
  purchase_request_id: string | null
  // Value is only reliable for purchase_request rows (unit_price known).
  // For master_stock we fall back to product.price as an estimate.
  unit_price: number | null
  total_value: number | null
  total_value_is_estimate: boolean
  notes: string | null
}

export interface SiteReceiptsMonth {
  year: number
  month: number
  monthName: string
  totalQuantity: number
  totalValue: number
  totalValueIsEstimate: boolean
  bySource: Record<ReceiptSource, { quantity: number; value: number }>
  rows: SiteReceiptRow[]
}

const MONTH_NAMES_PT = [
  'Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun',
  'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez',
]

function parsePurchaseRequestIdFromNotes(notes: string | null): string | null {
  if (!notes) return null
  // New format: "PR:<uuid>"
  const m1 = notes.match(/PR:([0-9a-fA-F-]{36})/)
  if (m1?.[1]) return m1[1]
  // Legacy format: "...purchase request <8-hex>..."
  const m2 = notes.match(/purchase request\s+([0-9a-fA-F]{8})/)
  if (m2?.[1]) return m2[1] // prefix, resolved later
  return null
}

function getSourceFromNotes(notes: string | null): ReceiptSource {
  if (!notes) return 'master_stock'
  if (notes.includes('PR:') || notes.toLowerCase().includes('purchase request')) return 'purchase_request'
  return 'master_stock'
}

export async function getSiteReceiptsByMonth(
  siteId: string,
  monthsBack: number = 12
): Promise<SiteReceiptsMonth[]> {
  const supabase = await createServerSupabaseClient()

  const now = new Date()
  const start = new Date(now.getFullYear(), now.getMonth() - (monthsBack - 1), 1)

  const { data: movements, error } = await supabase
    .from('stock_movements')
    .select(`
      id,
      created_at,
      product_id,
      quantity,
      notes,
      product:products(id, name, unit, price)
    `)
    .eq('movement_type', 'TRANSFER_IN')
    .eq('site_id', siteId)
    .gte('created_at', start.toISOString())
    .order('created_at', { ascending: false })

  if (error) throw error

  const rowsRaw = (movements || []).map((m: any) => {
    const qty = Math.floor(Number(m.quantity || 0))
    const source = getSourceFromNotes(m.notes)
    const prToken = source === 'purchase_request' ? parsePurchaseRequestIdFromNotes(m.notes) : null
    return {
      created_at: m.created_at,
      product_id: m.product_id,
      product_name: m.product?.name || 'Unknown',
      product_unit: m.product?.unit || '',
      product_price: Number(m.product?.price || 0),
      quantity: qty,
      source,
      purchase_request_token: prToken, // may be uuid or 8-char prefix
      notes: m.notes || null,
    }
  }).filter(r => r.quantity > 0)

  // Resolve purchase_request_id tokens (uuid or 8-char prefix -> uuid)
  const prTokens = [...new Set(rowsRaw.map(r => r.purchase_request_token).filter(Boolean))] as string[]
  const prIdMap = new Map<string, string>() // token -> full uuid

  const uuidTokens = prTokens.filter(t => t.length === 36)
  uuidTokens.forEach(t => prIdMap.set(t, t))

  const prefixTokens = prTokens.filter(t => t.length === 8)
  if (prefixTokens.length > 0) {
    const { data: prs } = await supabase
      .from('purchase_requests')
      .select('id')
      .is('deleted_at', null)
      .or(prefixTokens.map(p => `id.ilike.${p}%`).join(','))
    ;(prs || []).forEach((pr: any) => {
      const prefix = String(pr.id).slice(0, 8)
      if (prefixTokens.includes(prefix)) prIdMap.set(prefix, pr.id)
    })
  }

  // Fetch unit prices for purchase request items to compute value
  const prIds = [...new Set([...prIdMap.values()])]
  const unitPriceMap = new Map<string, number>() // `${prId}:${productId}` -> unit_price

  if (prIds.length > 0) {
    const { data: prItems } = await supabase
      .from('purchase_request_items')
      .select('purchase_request_id, product_id, unit_price')
      .in('purchase_request_id', prIds)
    ;(prItems || []).forEach((it: any) => {
      const key = `${it.purchase_request_id}:${it.product_id}`
      const up = it.unit_price === null ? null : Number(it.unit_price)
      if (up !== null && Number.isFinite(up)) unitPriceMap.set(key, up)
    })
  }

  const finalized: SiteReceiptRow[] = rowsRaw.map((r) => {
    const prId = r.purchase_request_token ? (prIdMap.get(r.purchase_request_token) || null) : null

    let unitPrice: number | null = null
    let isEstimate = true
    if (r.source === 'purchase_request' && prId) {
      const key = `${prId}:${r.product_id}`
      const up = unitPriceMap.get(key)
      if (up !== undefined) {
        unitPrice = up
        isEstimate = false
      }
    }

    if (unitPrice === null) {
      unitPrice = r.product_price || null
      isEstimate = true
    }

    const total = unitPrice !== null ? Number((r.quantity * unitPrice).toFixed(2)) : null

    return {
      created_at: r.created_at,
      product_id: r.product_id,
      product_name: r.product_name,
      product_unit: r.product_unit,
      quantity: r.quantity,
      source: r.source,
      purchase_request_id: prId,
      unit_price: unitPrice,
      total_value: total,
      total_value_is_estimate: isEstimate,
      notes: r.notes,
    }
  })

  // Group by month
  const grouped = new Map<string, SiteReceiptsMonth>()
  for (const row of finalized) {
    const d = new Date(row.created_at)
    const year = d.getFullYear()
    const month = d.getMonth() + 1
    const key = `${year}-${month}`
    const monthName = `${MONTH_NAMES_PT[d.getMonth()]} ${String(year).slice(-2)}`

    if (!grouped.has(key)) {
      grouped.set(key, {
        year,
        month,
        monthName,
        totalQuantity: 0,
        totalValue: 0,
        totalValueIsEstimate: false,
        bySource: {
          purchase_request: { quantity: 0, value: 0 },
          master_stock: { quantity: 0, value: 0 },
        },
        rows: [],
      })
    }

    const g = grouped.get(key)!
    g.totalQuantity += row.quantity
    if (row.total_value !== null) {
      g.totalValue += row.total_value
      g.bySource[row.source].value += row.total_value
    }
    g.bySource[row.source].quantity += row.quantity
    g.totalValueIsEstimate = g.totalValueIsEstimate || row.total_value_is_estimate
    g.rows.push(row)
  }

  return [...grouped.values()].sort((a, b) => (a.year - b.year) || (a.month - b.month))
}


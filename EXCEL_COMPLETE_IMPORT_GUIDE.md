# 📊 Importação Completa do Excel - Guia

## ✅ Arquivo Gerado

**`import_excel_complete.sql`** - Importa TODAS as abas do Excel

## 📋 O que será importado:

### 1. **Products** (Supplies sheet)
- ✅ 54 produtos com preços
- ⚠️ `units_per_package` = 1 (padrão) - você precisa ajustar depois

### 2. **Sites** (Sites sheet)
- ✅ 10 sites
- ⚠️ "General" marcado como master - verifique se está correto

### 3. **Inventory** (Inventory sheet)
- ✅ Estoque atual por site
- ✅ Quantidades em `quantity_packages` (boxes fechadas)

### 4. **Purchase Requests** (Requests sheet) ⭐ NOVO
- ✅ 43 purchase requests (agrupados por Data + Site)
- ✅ 200 itens de pedidos
- ✅ Status mapeados:
  - "Ordered" → `approved`
  - "Pending" → `submitted`
  - "Relocated" → `draft`
  - "Fulfilled" → `fulfilled`

### 5. **Direct Purchases** (Purchases sheet) ⭐ NOVO
- ✅ 133 compras diretas
- ✅ Adicionadas ao **Master Warehouse** inventory
- ✅ Registros em `direct_purchases` table
- ✅ Stock movements criados

## ⚠️ Limitações e Ajustes Necessários:

### 1. **Purchase Requests:**
- Agrupados por **Data + Site** (múltiplos produtos na mesma data viram 1 request)
- `created_by` usa primeiro manager/owner encontrado
- Se não houver usuário, `created_by` será NULL
- Datas convertidas do formato Excel

### 2. **Direct Purchases:**
- Todas vão para **Master Warehouse** (não para o site original)
- `purchased_by` usa primeiro manager/owner encontrado
- Notas preservadas quando disponíveis

### 3. **Dados Incompletos:**
- Alguns registros podem ter datas faltando
- Alguns podem ter produtos/sites que não existem (serão ignorados)
- Status podem não mapear perfeitamente

## 📋 Passo a Passo:

### Passo 1: Limpar banco (opcional)
```sql
-- Rode: clean_database_before_import.sql
```

### Passo 2: Rodar migrations necessárias
Certifique-se de ter rodado:
- `migration_add_package_tracking.sql`
- `migration_fix_site_inventory_rls.sql`
- `migration_update_register_in_packages.sql`

### Passo 3: Importar dados
```sql
-- Rode: import_excel_complete.sql
```

### Passo 4: Verificar
O script inclui uma query de verificação no final mostrando:
- Quantos produtos foram importados
- Quantos sites
- Quantos registros de inventory
- Quantos purchase requests
- Quantos purchase request items
- Quantos direct purchases
- Quantos stock movements

## 🔍 Verificar Dados Importados:

```sql
-- Ver purchase requests importados
SELECT 
  pr.id,
  s.name as site,
  pr.status,
  pr.created_at,
  COUNT(pri.id) as items_count
FROM purchase_requests pr
LEFT JOIN sites s ON pr.site_id = s.id
LEFT JOIN purchase_request_items pri ON pr.id = pri.purchase_request_id
GROUP BY pr.id, s.name, pr.status, pr.created_at
ORDER BY pr.created_at DESC
LIMIT 10;

-- Ver direct purchases importados
SELECT 
  dp.id,
  p.name as product,
  dp.quantity_purchased,
  dp.unit_price,
  dp.purchased_at,
  dp.notes
FROM direct_purchases dp
JOIN products p ON dp.product_id = p.id
ORDER BY dp.purchased_at DESC
LIMIT 10;
```

## ⚠️ Importante:

1. **Revisar o SQL antes de rodar** - pode ter dados incompletos
2. **Verificar usuários** - precisa ter pelo menos 1 manager/owner no banco
3. **Verificar master site** - precisa ter um site com `is_master = true`
4. **Ajustar units_per_package** depois da importação para produtos que têm múltiplas units

## 🎯 Resultado Esperado:

Após a importação, você terá:
- ✅ Todos os produtos do Excel
- ✅ Todos os sites
- ✅ Estoque atual
- ✅ Histórico de purchase requests
- ✅ Histórico de compras diretas
- ✅ Stock movements para rastreamento

Tudo pronto para usar o sistema! 🚀

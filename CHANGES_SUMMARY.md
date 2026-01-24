# Resumo das Mudanças - Foco em Compras e Distribuição

## Objetivo
Ajustar o sistema para focar em **compras e distribuição** ao invés de controle rigoroso de estoque, conforme a natureza real do negócio.

## Mudanças Implementadas

### 1. ✅ Adicionado `target_site_id` em `purchase_request_items`
- **Migration SQL**: `migration_add_target_site_id.sql`
- Permite que supervisors especifiquem para qual site cada item deve ser distribuído ao criar o purchase request
- Campo opcional (nullable) para manter flexibilidade

### 2. ✅ Atualizado `PurchaseRequestForm`
- Adicionado campo "Target Site" para cada item
- Supervisors podem especificar o site de destino ao criar o request
- Lista de sites exclui o master warehouse (não faz sentido distribuir para o master)

### 3. ✅ Removidos Stock IN e Stock OUT completamente
- **Removido de**: InventoryActions, QuickActions, SiteQuickActions, SideMenu
- **Justificativa**: O sistema não controla entrada/saída manual de estoque. Produtos entram apenas via purchase requests (que vão para o master warehouse) e são distribuídos via transfers.
- **Mantido**: Apenas Transfer (usado para distribuição do master para sites)

### 4. ✅ Atualizado `DistributionForm`
- Agora pré-preenche a distribuição quando `target_site_id` está definido
- Mostra visualmente qual é o site de destino sugerido
- Facilita distribuição automática quando o target foi especificado

### 5. ✅ Atualizados Tipos TypeScript
- `purchase_request_items` agora inclui `target_site_id` em todos os tipos
- `DistributionItem` inclui `target_site_id` e `target_site_name`
- `PurchaseRequestItem` (server e client) atualizados

### 6. ✅ Atualizadas Queries
- `getDistributionItems()` agora busca e retorna `target_site_id`
- `getPurchaseRequestItems()` retorna `target_site_id` quando disponível

## Próximos Passos (Opcionais)

### 1. Dashboard Focado em Compras
- Criar seção destacando:
  - Purchase requests pendentes
  - Items prontos para distribuir
  - Histórico de compras e distribuições

### 2. Relatórios de Compras
- Total gasto por período
- Items comprados e distribuídos
- Análise de distribuições

## Como Aplicar as Mudanças

1. **Execute a migration no Supabase:**
   ```sql
   -- Copie e execute o conteúdo de migration_add_target_site_id.sql
   -- no SQL Editor do Supabase
   ```

2. **O código já está atualizado:**
   - Todos os componentes foram atualizados
   - Tipos TypeScript atualizados
   - Queries atualizadas

3. **Teste o fluxo:**
   - Crie um purchase request especificando target sites
   - Aprove e receba o request
   - Distribua os items (deve pré-preencher com target sites)

## Notas Importantes

- **Stock IN e Stock OUT**: Removidos completamente do sistema. Produtos entram apenas via purchase requests (que vão para o master warehouse) e são distribuídos via transfers.
- **Low Stock Alerts**: Mantidos como estão (você disse para deixar)
- **Transferências**: Mantidas como estão (sempre feitas por Manager) - usadas para distribuição do master para sites
- **Controle de Estoque**: Mantido, mas o foco agora é em rastrear compras e distribuições

## Arquivos Modificados

- `migration_add_target_site_id.sql` (novo)
- `src/types/database.ts`
- `src/components/purchase-requests/PurchaseRequestForm.tsx`
- `src/components/purchase-requests/DistributionForm.tsx`
- `src/components/inventory/InventoryActions.tsx` (removido Stock IN/OUT)
- `src/components/dashboard/QuickActions.tsx` (removido Stock IN/OUT)
- `src/components/inventory/SiteQuickActions.tsx` (removido Stock IN/OUT)
- `src/components/layout/SideMenu.tsx` (removido Stock IN/OUT do menu)
- `src/app/inventory/page.tsx` (atualizada mensagem)
- `src/lib/queries/distribution.server.ts`
- `src/lib/queries/purchase-requests.server.ts`
- `src/lib/queries/purchase-requests.ts`

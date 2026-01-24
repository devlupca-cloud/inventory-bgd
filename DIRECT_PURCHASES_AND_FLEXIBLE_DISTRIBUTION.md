# Compras Diretas e Distribuição Flexível

## Implementação

### 1. Compras Diretas (Direct Purchases)

**Problema resolvido:**
- Manager pode comprar produtos que não estão em nenhum purchase request
- Essas compras vão diretamente para o master warehouse
- Precisam aparecer no relatório mensal de gastos

**Solução implementada:**

#### Migration: `migration_add_direct_purchases.sql`
- Cria tabela `direct_purchases` para rastrear compras sem purchase request
- Campos: `product_id`, `quantity_purchased`, `unit_price`, `total_value`, `purchased_by`, `purchased_at`
- RLS policies para managers/owners

#### API Route: `/api/purchases/direct`
- Endpoint POST para criar compras diretas
- Valida permissões (apenas managers)
- Cria registro em `direct_purchases`
- Adiciona items ao master warehouse via `stock_movements`

#### Componente: `DirectPurchaseForm.tsx`
- Formulário para criar compras diretas
- Seleciona produto, quantidade, preço unitário
- Calcula valor total automaticamente
- Chama API route para criar compra

#### Página: `/purchase-requests/direct`
- Página dedicada para compras diretas
- Acessível apenas para managers
- Link adicionado no menu lateral

#### Queries atualizadas:
- `monthly-purchase-list.server.ts`: Inclui `direct_purchases` no relatório mensal
- `monthly-purchase-overview.server.ts`: Inclui `direct_purchases` no overview mensal

### 2. Distribuição Flexível

**Problema resolvido:**
- Ao distribuir itens de um purchase request, manager pode usar estoque do master warehouse
- Não precisa usar apenas os itens específicos daquele request
- Pode usar itens de outros requests ou compras diretas

**Solução implementada:**

#### Query: `distribution-flexible.server.ts`
- Nova função `getFlexibleDistributionItems()`
- Retorna todos os produtos disponíveis no master warehouse
- Para cada produto, mostra:
  - `master_stock`: Total disponível no master
  - `from_request`: Items do purchase request específico (se houver)
  - `additional_stock`: Stock adicional de outras fontes

#### Componente: `DistributionForm.tsx` atualizado
- Aceita `flexibleItems` como prop opcional
- Se disponível, mostra todos os produtos do master
- Indica claramente:
  - Quantidade do request específico
  - Quantidade adicional de outras fontes
  - Total disponível no master
- Permite distribuir até o total disponível no master (não apenas do request)

#### Página: `/purchase-requests/[id]/distribute` atualizada
- Usa `getFlexibleDistributionItems()` para buscar estoque flexível
- Passa `flexibleItems` para o `DistributionForm`
- Mensagem explicativa sobre poder usar estoque do master

## Fluxo Completo

### Cenário 1: Compras Diretas
1. Manager acessa "Direct Purchase" no menu
2. Seleciona produto, quantidade, preço
3. Sistema cria registro em `direct_purchases`
4. Items são adicionados ao master warehouse
5. Compra aparece no relatório mensal

### Cenário 2: Distribuição Flexível
1. Manager acessa distribuição de um purchase request
2. Sistema mostra:
   - Items do request específico
   - Items adicionais do master (de outros requests/compras diretas)
3. Manager pode distribuir qualquer quantidade disponível no master
4. Não precisa usar apenas os items do request específico

## Benefícios

1. **Flexibilidade**: Manager pode usar todo o estoque do master, não apenas de um request
2. **Rastreamento**: Compras diretas são rastreadas e aparecem nos relatórios
3. **Transparência**: Sistema mostra claramente de onde vem cada item
4. **Eficiência**: Não precisa criar purchase request para compras pequenas/urgentes

## Próximos Passos (Opcionais)

1. Adicionar filtros na distribuição (mostrar apenas items do request, ou todos)
2. Histórico de distribuições mostrando origem dos items
3. Alertas quando distribuir mais do que veio do request específico
4. Dashboard mostrando compras diretas vs purchase requests

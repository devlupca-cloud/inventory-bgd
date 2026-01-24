# Análise do Fluxo de Purchase Requests

## Fluxo Atual

1. **Supervisor cria request** (draft)
   - Seleciona "Site" (confuso - qual site?)
   - Adiciona items com target_site_id ✅
   - Cria como draft

2. **Supervisor submete** (submitted)
   - Status muda para submitted
   - Não pode mais editar

3. **Manager aprova** (approved)
   - Status muda para approved
   - Pronto para comprar

4. **Manager registra compra** (fulfilled/partially_fulfilled)
   - Items vão para Master Warehouse ✅
   - Status muda para fulfilled

5. **Manager distribui** (via DistributionForm)
   - Distribui do master para sites
   - Usa target_site_id quando disponível ✅

## Problemas Identificados

### 1. Lista de Purchase Requests
- ❌ Não mostra valor total estimado
- ❌ Não mostra quantidade de items
- ❌ Não mostra target sites
- ❌ Campo "Site" é confuso (é o site que pediu, não onde vai)

### 2. Formulário de Criação
- ⚠️ Campo "Site" no topo é confuso
- ✅ Target site por item está bom
- ⚠️ Poderia mostrar resumo melhor

### 3. Detalhe do Request
- ❌ Não mostra target_site_id nos items da tabela
- ❌ Não mostra valor total gasto (só estimado)
- ❌ Não mostra preço unitário real vs estimado
- ❌ Não destaca produtos comprados
- ⚠️ Falta resumo financeiro claro

### 4. Visualização de Produtos Comprados
- ⚠️ Não há página dedicada para "o que foi comprado"
- ⚠️ Difícil ver histórico de compras
- ⚠️ Falta visão consolidada de gastos

## Melhorias Propostas

### 1. Melhorar Lista de Purchase Requests
- Adicionar coluna "Total Value" (estimado)
- Adicionar coluna "Items" (quantidade)
- Mostrar target sites resumidos
- Melhorar labels (ex: "Requesting Site" ao invés de "Site")

### 2. Melhorar Detalhe do Request
- Mostrar target_site_id na tabela de items
- Adicionar resumo financeiro:
  - Valor estimado (quantity_requested * unit_price)
  - Valor gasto (quantity_received * unit_price_real)
  - Diferença
- Destacar produtos comprados
- Mostrar preço real vs estimado

### 3. Melhorar Formulário
- Renomear "Site" para "Requesting Site" ou "Origin Site"
- Adicionar tooltip explicando o fluxo
- Melhorar visualização do resumo

### 4. Criar Visão de Produtos Comprados
- Página/seção mostrando o que foi realmente comprado
- Agrupado por produto
- Mostrar total gasto por produto
- Mostrar distribuições

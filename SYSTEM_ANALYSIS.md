# Análise do Sistema - Inventory BGD

## 📊 Estado Atual do Sistema

### Fluxo de Purchase Request (Atual)
1. **Supervisor cria request** → Status: `draft` → Associado ao Master Warehouse
2. **Supervisor submete** → Status: `submitted`
3. **Manager aprova** → Status: `approved` → Pode ajustar stock baseado em `current_quantity_observed`
4. **Manager registra compra** → Items vão para **Master Warehouse** → Status: `fulfilled`/`partially_fulfilled`
5. **❌ PROBLEMA**: Não há forma de distribuir do Master para os sites que precisam

### Problemas Identificados

#### 🔴 Críticos
1. **Falta de distribuição após compra**
   - Items ficam no Master Warehouse após recebimento
   - Não há interface para distribuir para sites
   - Purchase request tem `site_id` mas sempre usa master (confuso)

2. **Purchase Request Items não têm site_id**
   - Um request pode ter items para múltiplos sites, mas não há como especificar
   - A distribuição fica manual e sem rastreamento

#### 🟡 Médios
3. **Páginas obsoletas ainda existem**
   - `/movements/in`, `/movements/out`, `/movements/transfer` → Deveriam ser só modais
   - `/alerts` → Deveria ser só modal
   - Essas páginas ainda funcionam mas não fazem sentido no fluxo atual

4. **Histórico de ações é inferido, não real**
   - Não há tabela de audit log
   - Histórico é construído logicamente baseado no status atual
   - Não rastreia quem fez cada ação (exceto criação/aprovação)

5. **Purchase Request sempre associado ao Master**
   - O campo `site_id` no request não faz mais sentido
   - Deveria ter `site_id` nos items ou uma tabela de distribuição

#### 🟢 Melhorias de UX
6. **Falta visibilidade de distribuição pendente**
   - Não há indicação de items no master que precisam ser distribuídos
   - Não há lista de "pending distributions"

7. **Falta rastreamento de origem**
   - Quando um item é transferido do master para um site, não fica claro que veio de um purchase request específico

---

## 💡 Propostas de Melhoria

### 1. Sistema de Distribuição (PRIORIDADE ALTA)

#### Opção A: Distribuição por Purchase Request Item (Recomendado)
- Adicionar `target_site_id` em `purchase_request_items`
- Quando criar request, supervisor especifica para qual site cada item é
- Após receber compra, mostrar interface de distribuição automática
- Criar transfers automáticos do master para os sites de destino

**Vantagens:**
- Rastreamento completo desde a request até o site final
- Distribuição automática possível
- Histórico claro

**Desvantagens:**
- Requer migration para adicionar campo
- Precisa atualizar formulário de criação

#### Opção B: Distribuição Manual Pós-Compra (Mais Flexível)
- Após receber compra, mostrar interface de distribuição
- Manager escolhe quanto distribuir para cada site
- Criar transfers do master para sites
- Manter rastreamento via notes nos stock_movements

**Vantagens:**
- Mais flexível (pode redistribuir diferente do pedido original)
- Não requer mudança no schema atual
- Permite distribuição parcial

**Desvantagens:**
- Menos rastreamento automático
- Requer ação manual sempre

#### Opção C: Híbrida (Melhor UX)
- Adicionar `target_site_id` opcional em `purchase_request_items`
- Se especificado, sugerir distribuição automática
- Se não, permitir distribuição manual
- Interface visual mostrando: "Items prontos para distribuir"

**Interface Proposta:**
```
┌─────────────────────────────────────────┐
│ Purchase Request #123 - Fulfilled      │
├─────────────────────────────────────────┤
│ Items Received in Master Warehouse:    │
│                                         │
│ ✓ Product A - 50 units → Site X (auto)│
│ ✓ Product B - 30 units → [Distribute]  │
│ ✓ Product C - 20 units → Site Y (auto)│
│                                         │
│ [Distribute All] [Distribute Selected]  │
└─────────────────────────────────────────┘
```

### 2. Remover Páginas Obsoletas

**Ações:**
- Deletar `/app/movements/in/page.tsx`
- Deletar `/app/movements/out/page.tsx`
- Deletar `/app/movements/transfer/page.tsx`
- Deletar `/app/alerts/page.tsx`
- Manter apenas os modais

**Justificativa:**
- Modais já implementados e funcionando
- Páginas duplicam funcionalidade
- Melhor UX com modais (não sai da página atual)

### 3. Criar Tabela de Histórico Real

**Migration proposta:**
```sql
CREATE TABLE purchase_request_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  purchase_request_id UUID REFERENCES purchase_requests(id),
  action VARCHAR(50) NOT NULL, -- 'created', 'submitted', 'approved', 'rejected', 'received', 'distributed'
  performed_by UUID REFERENCES user_profiles(id),
  performed_at TIMESTAMPTZ DEFAULT NOW(),
  metadata JSONB, -- Para dados extras (quantities, sites, etc)
  notes TEXT
);
```

**Vantagens:**
- Histórico completo e preciso
- Rastreamento de todas as ações
- Possibilidade de auditoria

### 4. Dashboard de Distribuição Pendente

**Nova página/seção:**
- Mostrar items no master que vieram de purchase requests
- Agrupar por purchase request
- Mostrar status: "Pronto para distribuir", "Parcialmente distribuído", "Completo"
- Ações rápidas: "Distribuir tudo", "Distribuir selecionado"

---

## ❓ Perguntas em Aberto

1. **Distribuição automática ou manual?**
   - Você prefere que o sistema sugira distribuição automática baseada no request original?
   - Ou prefere sempre distribuir manualmente após receber a compra?

2. **Purchase Request Items devem ter site_id?**
   - Quando supervisor cria request, ele já sabe para qual site cada item é?
   - Ou isso só fica claro na hora de distribuir?

3. **Distribuição parcial é comum?**
   - Você distribui tudo de uma vez ou faz distribuições parciais ao longo do tempo?
   - Precisa rastrear "quanto ainda falta distribuir"?

4. **Histórico de ações é crítico?**
   - Precisa de auditoria completa ou o histórico inferido atual é suficiente?
   - Há requisitos de compliance que exigem histórico detalhado?

5. **Remover páginas obsoletas?**
   - Posso deletar as páginas `/movements/*` e `/alerts` já que temos modais?

---

## 🎯 Recomendação Final

**Implementar Opção C (Híbrida) para distribuição:**
1. Adicionar `target_site_id` opcional em `purchase_request_items`
2. Criar interface de distribuição visual e intuitiva
3. Permitir distribuição automática (se site especificado) ou manual
4. Criar dashboard de "Pending Distributions"
5. Remover páginas obsoletas
6. Criar tabela de histórico (opcional, mas recomendado)

**UX Proposta para Distribuição:**
- Modal ou página dedicada mostrando items no master
- Visual tipo "kanban" ou lista com ações rápidas
- Drag & drop ou seleção múltipla para distribuir
- Preview antes de confirmar
- Feedback visual do progresso

---

## 📝 Próximos Passos

Aguardando suas respostas para:
1. Escolher abordagem de distribuição
2. Confirmar remoção de páginas obsoletas
3. Decidir sobre histórico real vs inferido
4. Aprovar proposta de UX para distribuição

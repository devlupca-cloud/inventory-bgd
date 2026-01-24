# 🎲 Seed Fake Data Instructions

Este script cria dados de teste realistas para você visualizar todo o sistema funcionando.

## 📋 O que será criado:

### 🏢 **Sites (5 total)**
- **Master Warehouse** (central)
- **Chef's Hall Restaurant** (restaurante)
- **HHR Law Firm** (escritório de advocacia)
- **Downtown Office** (escritório)
- **Tech Center** (centro de tecnologia)

### 📦 **Produtos (10 itens)**
- Alimentos: Rice, Beans, Oil, Salt, Sugar
- Bebidas: Coffee
- Higiene/Limpeza: Toilet Paper, Soap, Cleaner, Wipes

### 📝 **Purchase Requests (6 requests)**
- **October 2025**: 1 request fulfilled (R$ ~1,200)
- **November 2025**: 1 request fulfilled (R$ ~1,400)
- **December 2025**: 1 request fulfilled (R$ ~2,800)
- **January 2026**: 1 fulfilled, 1 approved (ready to purchase), 1 submitted (waiting approval)

### 💰 **Direct Purchases (6 compras)**
- Distribuídas entre Out/2025 e Jan/2026
- Total: R$ ~1,200

### 📊 **Gráfico Mensal**
Com esses dados, você verá o gráfico mostrando gastos de **Out/2025 até Jan/2026**:
- **Out/25**: ~R$ 1,500
- **Nov/25**: ~R$ 1,700
- **Dez/25**: ~R$ 3,200
- **Jan/26**: ~R$ 1,100

### 📦 **Inventário**
- Master Warehouse com estoque variado (alguns items aguardando distribuição)
- Cada site com seu estoque atual
- Total: ~40 registros de inventário

### 🔄 **Stock Movements**
- Compras para Master Warehouse
- Distribuições parciais e completas para sites
- Total: ~30+ movimentações

## 🚀 Como executar:

### **Passo 1: Pegue seu User ID**

Execute no Supabase SQL Editor:

```sql
SELECT id, email FROM auth.users;
```

Copie o `id` (UUID) do seu usuário.

### **Passo 2: Edite o script**

Abra o arquivo `seed_fake_data.sql` e na linha 12, substitua:

```sql
v_user_id UUID := 'YOUR_USER_ID'; -- CHANGE THIS!
```

Por:

```sql
v_user_id UUID := 'seu-uuid-aqui';
```

### **Passo 3: Execute o script**

1. Acesse **Supabase Dashboard** → **SQL Editor**
2. Cole todo o conteúdo do arquivo `seed_fake_data.sql`
3. Clique em **Run**
4. Aguarde a mensagem de sucesso

### **Passo 4: Verifique**

O script mostra um resumo no final:

```
Sites Created: 5
Products Created: 10
Purchase Requests: 6
Purchase Request Items: 18
Stock Movements: 30+
Direct Purchases: 6
Site Inventory Records: 40+
```

## ✨ O que você poderá testar:

### **Dashboard**
- ✅ Gráfico de gastos mensais (Out-Jan) com barras
- ✅ Cards de resumo financeiro
- ✅ Lista de pending requests
- ✅ Visão geral dos sites

### **Purchase Requests**
- ✅ Lista com diferentes status
- ✅ Detalhe com items e target sites
- ✅ Editar draft
- ✅ Aprovar request
- ✅ Registrar compra (auto-fill)
- ✅ Distribution tracking (quem pediu vs quem recebeu)

### **Distribution**
- ✅ Distribuir items do Master para sites
- ✅ Ver target sites sugeridos
- ✅ Flexible distribution

### **Inventário**
- ✅ Master Warehouse com estoque
- ✅ Inventário de cada site
- ✅ Low stock alerts

### **Sites**
- ✅ Lista de sites
- ✅ Editar sites
- ✅ Ver métricas de compras por site

### **Direct Purchases**
- ✅ Criar compra direta
- ✅ Ver no monthly spending

## 🧹 Limpar dados (opcional)

Se quiser resetar, descomente as linhas 42-48 do script:

```sql
DELETE FROM stock_movements;
DELETE FROM purchase_request_items;
DELETE FROM purchase_requests;
DELETE FROM direct_purchases;
DELETE FROM site_inventory;
DELETE FROM products;
DELETE FROM sites WHERE name != 'Master Warehouse';
```

## 💡 Dicas:

1. **Primeiro teste**: Deixe os dados existentes e execute o script
2. **Ver o gráfico**: Vá em `/purchase-requests/monthly` para ver o gráfico completo
3. **Testar edição**: Tem 1 request em "submitted" que você pode aprovar
4. **Testar compra**: Tem 1 request "approved" pronta para registrar compra
5. **Testar distribuição**: Depois de registrar compra, vá em "Distribute Between Sites"

## 🎯 Dados realistas:

- Sites com nomes e endereços fictícios
- Produtos comuns de restaurante + escritório
- Preços em Real (R$)
- Requests distribuídos ao longo de 4 meses
- Algumas distribuições parciais (para testar pending items)
- Mix de status: draft, submitted, approved, fulfilled

Pronto! Agora você tem um sistema completo para testar! 🚀

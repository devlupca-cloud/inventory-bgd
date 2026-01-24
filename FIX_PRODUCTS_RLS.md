# 🔒 Fix RLS Policy for Products Table

## Problema

Erro: `new row violates row-level security policy for table "products"`

Isso acontece porque as políticas RLS (Row-Level Security) estão bloqueando inserções na tabela `products`.

## Solução

Você tem **2 opções**:

### Opção 1: Adicionar Políticas RLS (Recomendado para Produção)

Rode esta migration no Supabase SQL Editor:

**Arquivo:** `migration_fix_products_rls.sql`

Esta migration:
- ✅ Permite que **managers e owners** insiram produtos
- ✅ Permite que **managers e owners** atualizem produtos
- ✅ Permite que **todos os usuários autenticados** leiam produtos
- ✅ Permite soft delete (deleted_at) para managers/owners

**Como usar:**
1. Abra o Supabase Dashboard
2. Vá em SQL Editor
3. Cole o conteúdo de `migration_fix_products_rls.sql`
4. Execute

### Opção 2: Usar Função RPC para Imports (Recomendado para Imports em Massa)

Se você está importando muitos produtos (como do Excel), use uma função RPC que bypassa RLS:

**Arquivo:** `migration_create_product_import_rpc.sql`

Esta função:
- ✅ Usa `SECURITY DEFINER` para bypassar RLS
- ✅ Faz UPSERT (insere ou atualiza se já existe)
- ✅ Pode ser chamada pelo script de importação

**Como usar:**
1. Rode `migration_create_product_import_rpc.sql` no Supabase
2. Modifique o script de importação para usar `rpc_import_product()` ao invés de `INSERT`

## Para o Script de Importação do Excel

Se você está rodando `import_excel_complete.sql` e recebeu esse erro, você tem 2 opções:

### A) Rodar a migration de RLS primeiro (Opção 1)
Depois rode o script de importação normalmente.

### B) Modificar o script para usar a função RPC (Opção 2)
Substitua os `INSERT INTO products` por chamadas à função `rpc_import_product()`.

**Exemplo de mudança:**

**Antes:**
```sql
INSERT INTO products (name, unit, base_unit, units_per_package, price, created_at, updated_at)
VALUES ('Product Name', 'box', 'unit', 1, 10.00, NOW(), NOW());
```

**Depois:**
```sql
SELECT rpc_import_product('Product Name', 'box', 'unit', 1, 10.00);
```

## Recomendação

Para **produção**: Use a **Opção 1** (políticas RLS) - é mais seguro e segue as melhores práticas.

Para **imports em massa**: Use a **Opção 2** (função RPC) - é mais eficiente e não requer ajustar todas as políticas.

Você pode usar **ambas** - as políticas RLS para operações normais e a função RPC para imports.

## Verificação

Após rodar a migration, teste:

1. **Criar produto via UI** - deve funcionar se você for manager/owner
2. **Ver produtos** - deve funcionar para todos os usuários autenticados
3. **Importar produtos** - deve funcionar se usar a função RPC ou se tiver permissão

## Nota Importante

Se você está rodando o script de importação como **service role** (usando a API key do service role), o RLS não se aplica. O erro só acontece se estiver usando credenciais de usuário autenticado.

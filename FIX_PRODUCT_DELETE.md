# 🔧 Fix Product Delete Issue

## Problema

O delete de produtos não está funcionando devido a políticas RLS (Row-Level Security). O erro é:
```
new row violates row-level security policy for table "products"
```

## Solução (Recomendada)

### Passo 1: Criar Função RPC para Delete

Rode a migration `migration_create_product_delete_rpc.sql` no Supabase SQL Editor:

```sql
-- Esta migration cria uma função rpc_delete_product() que:
-- ✅ Usa SECURITY DEFINER para bypassar problemas de RLS
-- ✅ Valida que o usuário é manager/owner
-- ✅ Faz soft delete (seta deleted_at)
-- ✅ Retorna mensagem de sucesso/erro
```

**Esta é a solução recomendada** porque:
- Bypassa problemas de RLS com `WITH CHECK`
- Similar ao que já é usado para deletar sites (`rpc_delete_site`)
- Mais confiável e consistente

### Passo 2 (Opcional): Rodar a Migration de RLS

Se você ainda quiser usar UPDATE direto, rode `migration_fix_products_rls.sql`:

```sql
-- Esta migration:
-- ✅ Permite managers/owners atualizarem produtos
-- ✅ Permite managers/owners inserirem produtos
-- ✅ Permite todos os usuários autenticados lerem produtos
```

**Nota:** A função RPC é mais confiável e já está implementada no código.

### Passo 2: Verificar Permissões do Usuário

A função RPC já valida as permissões, mas você pode verificar:

```sql
SELECT id, email, role 
FROM user_profiles 
WHERE id = auth.uid();
```

Se o usuário não tiver role `manager` ou `owner`, atualize:

```sql
UPDATE user_profiles 
SET role = 'manager' 
WHERE id = auth.uid();
```

### Passo 3: Testar o Delete

O código já foi atualizado para usar a função RPC. Após rodar a migration, o delete deve funcionar automaticamente.

1. Tente deletar um produto pela UI
2. Abra o Console do navegador (F12) para ver erros detalhados
3. Se ainda não funcionar, verifique a mensagem de erro

## Como Funciona o Delete

O sistema usa **soft delete**:
- Não remove o produto do banco
- Apenas seta o campo `deleted_at` com a data/hora atual
- Produtos deletados não aparecem nas listagens (filtro `deleted_at IS NULL`)

## Troubleshooting

### Erro: "new row violates row-level security policy"

**Causa:** Políticas RLS estão bloqueando o UPDATE direto.

**Solução:** Rode `migration_create_product_delete_rpc.sql` (recomendado) ou `migration_fix_products_rls.sql`

**Nota:** O código já foi atualizado para usar a função RPC, então após rodar a migration, deve funcionar automaticamente.

### Erro: "permission denied"

**Causa:** Usuário não tem role `manager` ou `owner`.

**Solução:** Atualize o role do usuário na tabela `user_profiles`.

### Delete não aparece no console mas produto não some

**Causa:** Pode ser cache do Next.js ou problema com `router.refresh()`.

**Solução:** 
- Recarregue a página manualmente
- Verifique se o `deleted_at` foi setado no banco:
  ```sql
  SELECT id, name, deleted_at 
  FROM products 
  WHERE id = 'product-id-here';
  ```

## Verificação

Após rodar a migration, teste:

1. ✅ Criar produto (deve funcionar)
2. ✅ Editar produto (deve funcionar)
3. ✅ Deletar produto (deve funcionar agora)
4. ✅ Produto deletado não aparece na lista

## Notas

- O código já foi atualizado para mostrar mensagens de erro mais detalhadas
- Erros aparecem no console do navegador para debug
- A migration remove políticas duplicadas que podem causar conflitos

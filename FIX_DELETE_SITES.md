# Fix: Problema ao Deletar Sites

## Problema
A deleção de sites não está funcionando. Isso geralmente acontece por:
1. Coluna `deleted_at` não existe na tabela
2. Políticas RLS (Row Level Security) não permitem UPDATE
3. Permissões insuficientes

## Solução

### 1. Execute a Migration
Execute no SQL Editor do Supabase:
```sql
-- migration_ensure_deleted_at.sql
ALTER TABLE sites
ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMPTZ NULL;

CREATE INDEX IF NOT EXISTS idx_sites_deleted_at ON sites(deleted_at) WHERE deleted_at IS NULL;
```

### 2. Verifique as Políticas RLS

Verifique se existe uma política que permite UPDATE na tabela `sites` para managers/owners:

```sql
-- Verificar políticas existentes
SELECT * FROM pg_policies WHERE tablename = 'sites';

-- Se não existir, criar política para UPDATE
CREATE POLICY "Managers and owners can update sites"
ON sites
FOR UPDATE
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM user_profiles
    WHERE user_profiles.id = auth.uid()
    AND user_profiles.role IN ('manager', 'owner')
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM user_profiles
    WHERE user_profiles.id = auth.uid()
    AND user_profiles.role IN ('manager', 'owner')
  )
);
```

### 3. Alternativa: Criar RPC Function (Recomendado)

Se as políticas RLS continuarem bloqueando, crie uma RPC function:

```sql
-- RPC function para soft delete de sites
CREATE OR REPLACE FUNCTION rpc_delete_site(p_site_id UUID)
RETURNS JSON
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_user_role TEXT;
  v_is_master BOOLEAN;
BEGIN
  -- Verificar se usuário é manager ou owner
  SELECT role INTO v_user_role
  FROM user_profiles
  WHERE id = auth.uid();

  IF v_user_role NOT IN ('manager', 'owner') THEN
    RETURN json_build_object(
      'success', false,
      'message', 'Only managers and owners can delete sites'
    );
  END IF;

  -- Verificar se é master site
  SELECT is_master INTO v_is_master
  FROM sites
  WHERE id = p_site_id AND deleted_at IS NULL;

  IF v_is_master THEN
    RETURN json_build_object(
      'success', false,
      'message', 'Master warehouse cannot be deleted'
    );
  END IF;

  -- Soft delete
  UPDATE sites
  SET deleted_at = NOW(),
      updated_at = NOW()
  WHERE id = p_site_id
    AND deleted_at IS NULL;

  IF NOT FOUND THEN
    RETURN json_build_object(
      'success', false,
      'message', 'Site not found or already deleted'
    );
  END IF;

  RETURN json_build_object(
    'success', true,
    'message', 'Site deleted successfully'
  );
END;
$$;

-- Grant execute permission
GRANT EXECUTE ON FUNCTION rpc_delete_site(UUID) TO authenticated;
```

### 4. Atualizar o Código para Usar RPC (Opcional)

Se você criar a RPC function, atualize `SitesList.tsx`:

```typescript
const handleDelete = async (siteId: string, siteName: string, isMaster: boolean) => {
  // ... validações ...

  try {
    const { data, error } = await supabase.rpc('rpc_delete_site', {
      p_site_id: siteId
    })

    if (error) throw error
    if (!data?.success) {
      throw new Error(data?.message || 'Failed to delete site')
    }

    router.refresh()
  } catch (err: any) {
    // ... tratamento de erro ...
  }
}
```

## Teste

1. Execute a migration `migration_ensure_deleted_at.sql`
2. Verifique as políticas RLS
3. Tente deletar um site (não master)
4. Verifique o console do navegador para ver o erro exato
5. Se necessário, crie a RPC function

## Debug

Se ainda não funcionar, verifique:
- Console do navegador (F12) para ver o erro exato
- Network tab para ver a requisição HTTP
- Supabase logs para ver erros do servidor

# 🔧 Troubleshooting do Build no Vercel

## Problemas Comuns e Soluções

### 1. Erro de TypeScript

**Sintoma**: Build falha com erros de TypeScript no Vercel, mas funciona localmente.

**Solução**: 
- ✅ Já corrigido: Substituímos `as any` por `@ts-expect-error` nos arquivos RPC
- ✅ Verifique se todas as mudanças foram commitadas e enviadas para o GitHub

### 2. Variáveis de Ambiente Não Configuradas

**Sintoma**: Build passa, mas a aplicação não funciona (erros de conexão com Supabase).

**Solução**:
1. No dashboard do Vercel, vá em **Settings** → **Environment Variables**
2. Adicione:
   - `NEXT_PUBLIC_SUPABASE_URL` = sua URL do Supabase
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY` = sua chave anon do Supabase
3. Marque todas as opções (Production, Preview, Development)
4. Faça um novo deploy

### 3. Versão do Node.js

**Sintoma**: Erros de compatibilidade ou build falha.

**Solução**:
- O `vercel.json` já está configurado
- Se necessário, no Vercel vá em **Settings** → **General** → **Node.js Version** e selecione `20.x`

### 4. Dependências Não Instaladas

**Sintoma**: Erros de módulos não encontrados.

**Solução**:
- Verifique se o `package.json` está commitado
- Verifique se o `package-lock.json` está commitado
- No Vercel, vá em **Settings** → **General** → **Install Command** e certifique-se que está como `npm install`

### 5. Build Command Incorreto

**Sintoma**: Build não executa ou falha imediatamente.

**Solução**:
- No Vercel, vá em **Settings** → **General** → **Build Command**
- Deve estar como: `npm run build`
- O `vercel.json` já está configurado corretamente

### 6. Erro de Memória ou Timeout

**Sintoma**: Build para no meio ou demora muito.

**Solução**:
- Verifique os logs do Vercel para ver onde está travando
- Pode ser necessário aumentar o timeout (Vercel Pro) ou otimizar o build

## Checklist Antes de Fazer Deploy

- [ ] Todas as mudanças foram commitadas
- [ ] `git push` foi executado
- [ ] Variáveis de ambiente configuradas no Vercel
- [ ] Build local funciona (`npm run build`)
- [ ] Não há erros de lint (`npm run lint`)

## Como Ver os Logs de Erro no Vercel

1. Acesse o dashboard do Vercel
2. Clique no seu projeto
3. Vá em **Deployments**
4. Clique no deployment que falhou
5. Veja a aba **Build Logs** para ver o erro completo

## Próximos Passos

1. **Commit e Push**:
   ```bash
   git add .
   git commit -m "Fix TypeScript errors for Vercel build"
   git push
   ```

2. **Verificar Variáveis de Ambiente no Vercel**:
   - Vá em Settings → Environment Variables
   - Certifique-se que `NEXT_PUBLIC_SUPABASE_URL` e `NEXT_PUBLIC_SUPABASE_ANON_KEY` estão configuradas

3. **Fazer Novo Deploy**:
   - O Vercel faz deploy automaticamente quando você faz push
   - Ou vá em Deployments → "Redeploy"

4. **Se ainda falhar**:
   - Copie o erro completo dos logs do Vercel
   - Compartilhe aqui para análise

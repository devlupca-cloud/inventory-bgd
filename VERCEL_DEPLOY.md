# 🚀 Guia de Deploy no Vercel - Passo a Passo

## Pré-requisitos

✅ Código commitado e no GitHub  
✅ Conta no Vercel (gratuita)  
✅ Projeto Supabase criado e migrations rodadas  

---

## Passo 1: Preparar o Repositório no GitHub

Se ainda não fez push para o GitHub:

```bash
# Verificar se está tudo commitado
git status

# Se houver mudanças, commitar:
git add .
git commit -m "Prepare for deployment"

# Fazer push (se ainda não fez)
git push origin main
```

---

## Passo 2: Criar Conta no Vercel

1. Acesse [vercel.com](https://vercel.com)
2. Clique em **"Sign Up"**
3. Escolha uma opção:
   - **Recomendado**: Conectar com GitHub (mais fácil)
   - Ou criar conta com email
4. Autorize o Vercel a acessar seus repositórios (se usar GitHub)

---

## Passo 3: Importar Projeto no Vercel

1. No dashboard do Vercel, clique em **"Add New Project"** ou **"Import Project"**
2. Se conectou com GitHub, você verá seus repositórios
3. Selecione o repositório `inventory_bgd` (ou o nome do seu repo)
4. Clique em **"Import"**

---

## Passo 4: Configurar o Projeto

### 4.1 Configurações do Projeto

O Vercel deve detectar automaticamente:
- **Framework Preset**: Next.js ✅
- **Root Directory**: `./` (raiz do projeto)
- **Build Command**: `npm run build` (automático)
- **Output Directory**: `.next` (automático)

**Não precisa mudar nada aqui!** Apenas confirme.

### 4.2 Variáveis de Ambiente

**IMPORTANTE**: Antes de fazer deploy, configure as variáveis de ambiente!

1. Na seção **"Environment Variables"**, clique em **"Add"**
2. Adicione as seguintes variáveis:

#### Variável 1:
- **Name**: `NEXT_PUBLIC_SUPABASE_URL`
- **Value**: Sua URL do Supabase (ex: `https://xxxxxxxxxxxxx.supabase.co`)
- **Environments**: Marque todas (Production, Preview, Development)

#### Variável 2:
- **Name**: `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- **Value**: Sua chave anon do Supabase (começa com `eyJ...`)
- **Environments**: Marque todas (Production, Preview, Development)

**Como encontrar essas credenciais:**
1. Acesse seu projeto no [Supabase Dashboard](https://app.supabase.com)
2. Vá em **Settings** (ícone de engrenagem) → **API**
3. Copie:
   - **Project URL** → `NEXT_PUBLIC_SUPABASE_URL`
   - **anon public key** → `NEXT_PUBLIC_SUPABASE_ANON_KEY`

---

## Passo 5: Fazer o Deploy

1. Clique em **"Deploy"**
2. Aguarde o build (pode levar 2-5 minutos)
3. Se tudo der certo, você verá:
   - ✅ Build completed
   - Uma URL tipo: `https://inventory-bgd-xxxxx.vercel.app`

**Anote essa URL!** Você vai precisar dela no próximo passo.

---

## Passo 6: Configurar Supabase Auth (IMPORTANTE!)

Após o deploy, você precisa configurar o Supabase para aceitar a URL do Vercel:

1. Acesse [Supabase Dashboard](https://app.supabase.com)
2. Vá em **Authentication** → **URL Configuration**
3. Em **Redirect URLs**, adicione:
   ```
   https://sua-url-do-vercel.vercel.app/api/auth/callback
   ```
   (Substitua `sua-url-do-vercel` pela URL real que o Vercel gerou)

4. Clique em **"Save"**

**Por que isso é importante?**
- Sem isso, o login não vai funcionar em produção
- O Supabase precisa saber quais URLs são permitidas para redirecionamento

---

## Passo 7: Testar o Deploy

1. Acesse a URL do Vercel (ex: `https://inventory-bgd-xxxxx.vercel.app`)
2. Teste:
   - ✅ Página de login aparece
   - ✅ Página de sign up funciona
   - ✅ Login funciona (magic link ou senha)
   - ✅ Após login, redireciona para dashboard
   - ✅ Side menu aparece
   - ✅ Navegação funciona

---

## Passo 8: Configurar Domínio Personalizado (Opcional)

Se quiser usar um domínio próprio:

1. No Vercel, vá em **Settings** → **Domains**
2. Adicione seu domínio
3. Siga as instruções para configurar DNS
4. **Importante**: Atualize a URL de redirect no Supabase também!

---

## Troubleshooting

### ❌ Build falhou

**Erro comum**: Variáveis de ambiente não configuradas
- **Solução**: Verifique se adicionou `NEXT_PUBLIC_SUPABASE_URL` e `NEXT_PUBLIC_SUPABASE_ANON_KEY`

**Erro comum**: Erro de TypeScript
- **Solução**: Rode `npm run build` localmente primeiro para ver os erros

### ❌ Login não funciona

**Causa**: Redirect URL não configurada no Supabase
- **Solução**: Adicione a URL do Vercel em Supabase → Authentication → URL Configuration

### ❌ Erro 500 ao acessar páginas

**Causa**: Migrations não rodadas no Supabase
- **Solução**: Certifique-se de que todas as migrations foram executadas no Supabase production

### ❌ Side menu não aparece

**Causa**: Problema com autenticação
- **Solução**: Verifique se o usuário está logado e se as permissões estão corretas

---

## Checklist Final

Antes de considerar o deploy completo:

- [ ] Código está no GitHub
- [ ] Projeto importado no Vercel
- [ ] Variáveis de ambiente configuradas
- [ ] Deploy concluído com sucesso
- [ ] URL de redirect configurada no Supabase
- [ ] Login funciona em produção
- [ ] Sign up funciona em produção
- [ ] Dashboard carrega após login
- [ ] Navegação funciona
- [ ] Testado em mobile (iPhone)

---

## Próximos Passos

Após o deploy bem-sucedido:

1. **Criar usuários de teste** no Supabase
2. **Atribuir roles** aos usuários (manager, supervisor, etc.)
3. **Testar todas as funcionalidades** em produção
4. **Configurar backup** (Supabase faz isso automaticamente)

---

## Suporte

Se tiver problemas:
1. Verifique os logs no Vercel (Deployments → View Function Logs)
2. Verifique os logs no Supabase (Logs → Postgres Logs)
3. Teste localmente primeiro para isolar o problema

---

**Boa sorte com o deploy! 🚀**

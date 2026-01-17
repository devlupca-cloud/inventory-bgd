# Deployment Checklist

## Pre-Deployment

- [ ] All database migrations run in Supabase production
- [ ] Environment variables configured in Vercel
- [ ] Supabase auth redirect URLs updated
- [ ] PWA icons added (icon-192x192.png and icon-512x512.png in public/icons/)
- [ ] Test users created with appropriate roles

## Supabase Setup

1. **Create Production Project**
   - Go to [supabase.com](https://supabase.com)
   - Crie uma conta (se ainda não tiver) ou faça login
   - Clique em "New Project"
   - Preencha:
     - Nome do projeto
     - Senha do banco de dados (anote essa senha!)
     - Região (escolha a mais próxima)
   - Aguarde alguns minutos para o projeto ser criado

2. **Encontrar as Credenciais (URL e Anon Key)**
   - No dashboard do Supabase, vá em **Settings** (ícone de engrenagem no menu lateral)
   - Clique em **API**
   - Você verá:
     - **Project URL**: Algo como `https://xxxxxxxxxxxxx.supabase.co`
     - **anon/public key**: Uma chave longa que começa com `eyJ...`
   - **Copie essas duas informações** - você vai precisar delas!

2. **Run Migrations**
   - Go to SQL Editor
   - Run in order:
     - `001_initial_schema.sql`
     - `002_rls_policies.sql`
     - `003_rpc_functions.sql`
     - `004_triggers.sql`
   - Optionally run `seed.sql` for initial data

3. **Configure Authentication**
   - Go to Authentication > URL Configuration
   - Add redirect URL: `https://your-app.vercel.app/api/auth/callback`
     - ⚠️ **Importante**: Faça isso DEPOIS de fazer o deploy no Vercel para ter a URL correta
     - Para desenvolvimento local, também adicione: `http://localhost:3000/api/auth/callback`
   - Enable email provider
   - Configure email templates (optional)
   - **Nota**: Não é necessário configurar nada de autenticação no Vercel - apenas as variáveis de ambiente

4. **Create Initial Users**
   - Go to Authentication > Users
   - Create users or use sign-up flow
   - Update roles in `user_profiles` table:
     ```sql
     UPDATE user_profiles SET role = 'manager' WHERE email = 'admin@example.com';
     ```
   - Assign supervisors to sites:
     ```sql
     INSERT INTO site_user_roles (user_id, site_id)
     SELECT id, 'site-id' FROM user_profiles WHERE email = 'supervisor@example.com';
     ```

## Vercel Deployment

**Pré-requisito**: Você precisa criar uma conta gratuita no Vercel
- Acesse [vercel.com](https://vercel.com)
- Clique em "Sign Up" e crie uma conta (pode usar GitHub, GitLab, ou email)
- O plano gratuito é suficiente para começar

1. **Connect Repository**
   - Push code to GitHub (se ainda não fez)
   - No Vercel, clique em "Add New Project"
   - Import seu repositório do GitHub

2. **Configure Environment Variables**
   - `NEXT_PUBLIC_SUPABASE_URL` - Your Supabase project URL
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY` - Your Supabase anon key
   - **Nota**: Não precisa configurar nada de autenticação no Vercel - apenas essas variáveis de ambiente

3. **Deploy**
   - Vercel will auto-detect Next.js
   - Build should complete successfully
   - Note your deployment URL

## Post-Deployment

1. **Update Supabase Redirect URLs**
   - Add production URL to Supabase auth settings

2. **Test Authentication**
   - Try magic link login
   - Try password login
   - Verify redirect works

3. **Test Core Features**
   - [ ] View inventory
   - [ ] Register stock IN (manager/owner)
   - [ ] Register stock OUT (supervisor/manager/owner)
   - [ ] Transfer between sites
   - [ ] Create purchase request (supervisor)
   - [ ] Approve purchase request (manager)
   - [ ] Receive purchase request (manager)
   - [ ] View low stock alerts

4. **Test Mobile**
   - [ ] Open on iPhone Safari
   - [ ] Test all forms
   - [ ] Verify PWA install option (if icons added)
   - [ ] Test touch interactions

## Troubleshooting

### Authentication Issues
- Verify redirect URLs in Supabase match Vercel domain
- Check environment variables are set correctly
- Verify RLS policies allow authenticated users

### RPC Function Errors
- Check function permissions in Supabase
- Verify SECURITY DEFINER is set
- Check function logs in Supabase dashboard

### RLS Policy Issues
- Test policies with different user roles
- Verify helper functions work correctly
- Check user_profiles table has correct roles

## Maintenance

- Monitor Supabase usage (free tier limits)
- Monitor Vercel usage (free tier limits)
- Regular backups of database (Supabase handles this)
- Update dependencies regularly

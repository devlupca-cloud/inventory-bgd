# 🔄 Forçar Novo Deploy no Vercel

Se o Vercel ainda está mostrando R$ ao invés de $, siga estes passos:

## Opção 1: Redeploy via Vercel Dashboard (Recomendado)

1. Acesse https://vercel.com/dashboard
2. Encontre seu projeto
3. Vá em "Deployments"
4. Clique nos 3 pontos (...) do último deployment
5. Selecione "Redeploy"

## Opção 2: Forçar novo build via Git

Faça um commit vazio para forçar um novo build:

```bash
git commit --allow-empty -m "Force redeploy - currency update"
git push origin main
```

## Opção 3: Limpar cache do navegador

1. Abra DevTools (F12)
2. Clique com botão direito no botão de refresh
3. Selecione "Empty Cache and Hard Reload"

## Opção 4: Verificar se o build está correto

No Vercel Dashboard:
1. Vá em "Deployments"
2. Clique no último deployment
3. Veja os "Build Logs"
4. Verifique se não há erros

## Verificação

Após o redeploy, verifique se está mostrando "$" em:
- ✅ Lista de produtos
- ✅ Formulário de produtos
- ✅ Dashboard
- ✅ Purchase requests
- ✅ Inventory pages

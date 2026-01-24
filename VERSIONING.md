# 📦 Versionamento da Aplicação

## 📍 Onde a versão aparece:

A versão é exibida no **header** de todas as páginas, no canto superior direito.

## 🔢 Como atualizar a versão:

### Passo 1: Atualizar `src/lib/version.ts`
```typescript
export const APP_VERSION = '1.0.0'; // Mude para 1.0.1, 1.1.0, 2.0.0, etc.
```

### Passo 2: Atualizar `package.json`
```json
"version": "1.0.0" // Mantenha igual ao APP_VERSION
```

## 📋 Convenções de Versionamento (Semantic Versioning):

- **MAJOR** (1.0.0 → 2.0.0): Mudanças incompatíveis
- **MINOR** (1.0.0 → 1.1.0): Novas funcionalidades compatíveis
- **PATCH** (1.0.0 → 1.0.1): Correções de bugs

## 🎯 Exemplos:

- **1.0.0** → **1.0.1**: Correção de bug
- **1.0.0** → **1.1.0**: Nova feature (ex: novo gráfico)
- **1.0.0** → **2.0.0**: Refatoração grande ou mudança de arquitetura

## 📝 Checklist ao fazer release:

- [ ] Atualizar `src/lib/version.ts`
- [ ] Atualizar `package.json`
- [ ] Testar que a versão aparece corretamente no header
- [ ] Commit com mensagem: "Bump version to X.Y.Z"

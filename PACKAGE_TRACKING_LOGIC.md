# Sistema de Rastreamento: Boxes Fechadas vs Unidades Soltas

## Conceito

O sistema agora rastreia:
- **`quantity_packages`**: Boxes/pacotes completos e fechados
- **`quantity_loose_units`**: Unidades soltas de boxes abertas
- **`quantity_on_hand`**: Total calculado automaticamente (packages * units_per_package + loose_units)

## Fluxos

### 1. Compra de Produtos
**Quando você compra 3 boxes:**
```
quantity_packages += 3
quantity_loose_units += 0
quantity_on_hand = (3 * 12) + 0 = 36 units ✅
```

### 2. Enviar Box Fechada
**Quando você envia 1 box fechada:**
```
quantity_packages -= 1
quantity_loose_units += 0
quantity_on_hand = (2 * 12) + 0 = 24 units ✅
```

### 3. Enviar Unidades Soltas (Box Aberta)
**Quando você envia 15 units (mas só tem 2 boxes fechadas):**

**Passo 1: Abrir boxes conforme necessário**
- Precisa de 15 units
- Tem 2 boxes fechadas (24 units total)
- Abre 2 boxes: `quantity_packages -= 2`, `quantity_loose_units += 24`

**Passo 2: Enviar as units**
- Envia 15: `quantity_loose_units -= 15`
- Resultado: `quantity_packages = 0`, `quantity_loose_units = 9`

**Lógica de "abertura automática":**
```
Se precisa enviar X units:
  1. Calcular total disponível = (packages * units_per_package) + loose_units
  2. Se X > loose_units:
     - Calcular quantas boxes abrir: boxes_to_open = CEIL((X - loose_units) / units_per_package)
     - Abrir boxes: packages -= boxes_to_open, loose_units += (boxes_to_open * units_per_package)
  3. Enviar: loose_units -= X
```

## Exemplos Práticos

### Exemplo 1: Estoque Inicial
```
Mop Head:
- quantity_packages: 2 (boxes fechadas)
- quantity_loose_units: 5 (units soltas)
- units_per_package: 12
- Total: (2 * 12) + 5 = 29 units ✅
```

### Exemplo 2: Enviar 1 Box Fechada
```
Antes: 2 boxes, 5 loose
Envia: 1 box fechada
Depois: 1 box, 5 loose = 17 units ✅
```

### Exemplo 3: Enviar 15 Units
```
Antes: 2 boxes, 5 loose = 29 units
Precisa: 15 units
Abre: 1 box (12 units) → 1 box, 17 loose
Envia: 15 units
Depois: 1 box, 2 loose = 14 units ✅
```

### Exemplo 4: Enviar 30 Units (mais que boxes fechadas)
```
Antes: 2 boxes, 5 loose = 29 units
Precisa: 30 units
Abre: 2 boxes (24 units) → 0 boxes, 29 loose
Envia: 30 units
Depois: 0 boxes, -1 loose ❌ ERRO! Não tem estoque suficiente
```

## Regras de Negócio

1. **Sempre validar estoque antes de enviar**
2. **Abrir boxes automaticamente quando necessário**
3. **Não permitir loose_units negativas**
4. **Não permitir packages negativas**
5. **Sempre manter: loose_units < units_per_package** (após operações)

## Próximos Passos

1. ✅ Migration criada
2. ⏳ Atualizar tipos TypeScript
3. ⏳ Atualizar RPC functions
4. ⏳ Atualizar TransferForm
5. ⏳ Atualizar DistributionForm
6. ⏳ Atualizar Direct Purchase
7. ⏳ Atualizar InventoryTable para mostrar boxes + loose

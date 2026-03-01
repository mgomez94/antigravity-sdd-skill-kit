#!/usr/bin/env bash
# =============================================================================
# new_feature.sh
# Crea la estructura de carpetas y archivos para una nueva feature SDD
# Uso: bash scripts/new_feature.sh <ID> <slug>
# Ejemplo: bash scripts/new_feature.sh 001 user-authentication
# =============================================================================

set -e

FEATURE_ID=$1
FEATURE_SLUG=$2

if [ -z "$FEATURE_ID" ] || [ -z "$FEATURE_SLUG" ]; then
  echo ""
  echo "ERROR: Debes proveer ID y slug de la feature"
  echo "Uso: bash scripts/new_feature.sh <ID> <slug>"
  echo "Ejemplo: bash scripts/new_feature.sh 001 user-authentication"
  echo ""
  exit 1
fi

DIR=".specify/specs/${FEATURE_ID}-${FEATURE_SLUG}"

if [ -d "$DIR" ]; then
  echo "ERROR: La feature $DIR ya existe"
  exit 1
fi

mkdir -p "$DIR"

# Crear spec.md
cat > "${DIR}/spec.md" << EOF
# Especificación: [Nombre de la Feature]

**ID**: ${FEATURE_ID}
**Estado**: Draft
**Fecha**: $(date +%Y-%m-%d)
**Autor**: [Tu nombre]
**Revisor**: [Revisor]

---

## 1. Objetivo de Negocio

[Describe qué problema resuelve esta feature y por qué es importante.]

**Métrica de éxito**: [Cómo mediremos el éxito?]

---

## 2. Contexto

[Describe el estado actual y por qué se necesita este cambio.]

---

## 3. User Stories

### Historia 1: [Título]

**Como** [usuario]
**Quiero** [acción]
**Para** [beneficio]

**Escenario 1: Camino feliz**
\`\`\`
GIVEN [precondición]
WHEN [acción]
THEN [resultado esperado]
\`\`\`

**Escenario 2: Caso de error**
\`\`\`
GIVEN [precondición]
WHEN [acción]
THEN [resultado de error]
\`\`\`

---

## 4. Requisitos No Funcionales

- Rendimiento: [ej. < 200ms]
- Seguridad: [ej. autenticación requerida]

---

## 5. Casos Borde

| Caso | Comportamiento |
|---|---|
| [caso] | [comportamiento] |

---

## 6. Dependencias

- [Lista dependencias]
EOF

# Crear plan.md
cat > "${DIR}/plan.md" << EOF
# Plan Técnico: [Nombre de la Feature]

**Spec ID**: ${FEATURE_ID}
**Estado**: Draft
**Fecha**: $(date +%Y-%m-%d)

---

## 1. Resumen Arquitectónico

[Descripción de cómo se construirá esta feature.]

---

## 2. Componentes Afectados

| Componente | Tipo | Acción |
|---|---|---|
| [nombre] | Frontend/Backend/DB | Crear/Modificar |

---

## 3. Modelo de Datos

\`\`\`sql
-- Agregar SQL aquí
\`\`\`

---

## 4. Contratos de API

### [Método] [/ruta]

**Request:** \`{}\`
**Response:** \`{}\`

---

## 5. Decisiones Técnicas

| Decisión | Elección | Razón |
|---|---|---|
| [tipo] | [elección] | [razón] |
EOF

# Crear tasks.md
cat > "${DIR}/tasks.md" << EOF
# Tareas: [Nombre de la Feature]

**Spec ID**: ${FEATURE_ID}
**Plan aprobado**: No
**Fecha**: $(date +%Y-%m-%d)
**Tiempo total estimado**: [N] horas

---

## T-001: Setup/Migración [BLOCKER]
- **Tiempo**: 30 min
- **Acciones**:
  - [ ] [Acción 1]
  - [ ] [Acción 2]
- **Test**: [Verificación]

## T-002: Backend - Repository [P]
- **Tiempo**: 45 min
- **Dep**: T-001
- **Acciones**:
  - [ ] [Acción 1]
- **Test**: [Tests unitarios]

## T-003: Backend - Service [P]
- **Tiempo**: 45 min
- **Dep**: T-002
- **Acciones**:
  - [ ] [Acción 1]
- **Test**: [Tests unitarios]

## T-004: Backend - Controller/Routes
- **Tiempo**: 30 min
- **Dep**: T-003
- **Acciones**:
  - [ ] [Acción 1]
- **Test**: [Integration tests]

## T-005: Frontend
- **Tiempo**: 60 min
- **Dep**: T-004
- **Acciones**:
  - [ ] [Acción 1]
- **Test**: [Component tests]

## T-006: QA y Documentación
- **Tiempo**: 30 min
- **Acciones**:
  - [ ] Verificar todos los criterios GIVEN-WHEN-THEN
  - [ ] Crear IMPLEMENTATION_NOTES.md
EOF

echo ""
echo "==================================================="
echo "  Feature SDD creada: $DIR"
echo "==================================================="
echo ""
echo "Archivos creados:"
echo "  $DIR/spec.md"
echo "  $DIR/plan.md"
echo "  $DIR/tasks.md"
echo ""
echo "Próximos pasos:"
echo "  1. Edita spec.md con los requisitos de la feature"
echo "  2. Valida la spec: bash scripts/validate_spec.sh $DIR/spec.md"
echo "  3. Crea el plan técnico en plan.md"
echo "  4. Valida el plan: bash scripts/validate_plan.sh $DIR/plan.md"
echo "  5. Define las tareas en tasks.md"
echo "  6. Implementa!"
echo ""

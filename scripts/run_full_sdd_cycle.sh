#!/usr/bin/env bash
# =============================================================================
# run_full_sdd_cycle.sh
# Ejecuta el ciclo completo de validación SDD para una feature
# Uso: bash scripts/run_full_sdd_cycle.sh <ID> <slug>
# Ejemplo: bash scripts/run_full_sdd_cycle.sh 001 user-authentication
# =============================================================================

set -e

FEATURE_ID=$1
FEATURE_SLUG=$2
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -z "$FEATURE_ID" ] || [ -z "$FEATURE_SLUG" ]; then
  echo "Uso: bash scripts/run_full_sdd_cycle.sh <ID> <slug>"
  exit 1
fi

FEATURE_DIR=".specify/specs/${FEATURE_ID}-${FEATURE_SLUG}"
SPEC_FILE="$FEATURE_DIR/spec.md"
PLAN_FILE="$FEATURE_DIR/plan.md"
TASKS_FILE="$FEATURE_DIR/tasks.md"

echo ""
echo "==================================================="
echo "  SDD Cycle - Feature: ${FEATURE_ID}-${FEATURE_SLUG}"
echo "==================================================="

# Verificar que existe la carpeta de la feature
if [ ! -d "$FEATURE_DIR" ]; then
  echo ""
  echo "ERROR: Feature no encontrada: $FEATURE_DIR"
  echo "Primero créala con: bash scripts/new_feature.sh $FEATURE_ID $FEATURE_SLUG"
  exit 1
fi

# Verificar constitution
echo ""
echo "[GATE 0] Verificando Constitution..."
if [ -f ".specify/memory/constitution.md" ]; then
  echo "  OK: constitution.md existe"
else
  echo "  WARN: constitution.md no existe - ejecuta init_sdd_project.sh primero"
fi

# Validar spec
echo ""
echo "[GATE 1] Validando Spec..."
if [ -f "$SPEC_FILE" ]; then
  bash "$SCRIPT_DIR/validate_spec.sh" "$SPEC_FILE"
else
  echo "  ERROR: spec.md no encontrada en $FEATURE_DIR"
  echo "  Crea la spec antes de continuar"
  exit 1
fi

# Validar plan (si existe)
echo ""
echo "[GATE 2] Verificando Plan..."
if [ -f "$PLAN_FILE" ]; then
  bash "$SCRIPT_DIR/validate_plan.sh" "$PLAN_FILE"
else
  echo "  WARN: plan.md no encontrado todavía"
  echo "  Crea el plan técnico basado en la spec aprobada"
fi

# Validar tasks (si existe)
echo ""
echo "[GATE 3] Verificando Tasks..."
if [ -f "$TASKS_FILE" ]; then
  bash "$SCRIPT_DIR/validate_tasks.sh" "$TASKS_FILE"
else
  echo "  WARN: tasks.md no encontrado todavía"
  echo "  Crea las tareas después de aprobar el plan"
fi

# Resumen del estado
echo ""
echo "==================================================="
echo "  Resumen del Estado de la Feature"
echo "==================================================="
echo ""

ARTIFACTS=0

if [ -f ".specify/memory/constitution.md" ]; then
  echo "  [OK] constitution.md"
  ARTIFACTS=$((ARTIFACTS + 1))
else
  echo "  [MISSING] constitution.md"
fi

if [ -f "$SPEC_FILE" ]; then
  STATUS=$(grep -i "Estado:" "$SPEC_FILE" | head -1 | sed 's/.*Estado: *//' | tr -d '\r')
  echo "  [OK] spec.md (Estado: $STATUS)"
  ARTIFACTS=$((ARTIFACTS + 1))
else
  echo "  [MISSING] spec.md"
fi

if [ -f "$PLAN_FILE" ]; then
  STATUS=$(grep -i "Estado:" "$PLAN_FILE" | head -1 | sed 's/.*Estado: *//' | tr -d '\r')
  echo "  [OK] plan.md (Estado: $STATUS)"
  ARTIFACTS=$((ARTIFACTS + 1))
else
  echo "  [PENDING] plan.md - pendiente de creación"
fi

if [ -f "$TASKS_FILE" ]; then
  echo "  [OK] tasks.md"
  ARTIFACTS=$((ARTIFACTS + 1))
else
  echo "  [PENDING] tasks.md - pendiente de creación"
fi

IMPL_NOTES="$FEATURE_DIR/IMPLEMENTATION_NOTES.md"
if [ -f "$IMPL_NOTES" ]; then
  echo "  [OK] IMPLEMENTATION_NOTES.md"
  ARTIFACTS=$((ARTIFACTS + 1))
else
  echo "  [PENDING] IMPLEMENTATION_NOTES.md - crear después de implementar"
fi

echo ""
echo "Artefactos completados: $ARTIFACTS/5"
echo ""

if [ $ARTIFACTS -ge 4 ]; then
  echo "ESTADO: Listo para implementar o en implementación"
elif [ $ARTIFACTS -ge 2 ]; then
  echo "ESTADO: En progreso - completar artefactos pendientes"
else
  echo "ESTADO: En inicio - crea spec y plan antes de implementar"
fi
echo ""

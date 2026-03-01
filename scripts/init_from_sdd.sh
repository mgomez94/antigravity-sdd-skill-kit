#!/usr/bin/env bash
# init_from_sdd.sh
# Verifica que existan artefactos SDD antes de ejecutar el Fullstack Executor.
# Uso: bash scripts/init_from_sdd.sh [ruta_proyecto]

set -e

PROJECT_DIR="${1:-.}"
SPECIFY_DIR="${PROJECT_DIR}/.specify"

echo "============================================"
echo "  Fullstack SDD Executor - Verificacion SDD"
echo "============================================"
echo ""

# Verificar si existe .specify/
if [ ! -d "${SPECIFY_DIR}" ]; then
  echo "ERROR: No se encontro el directorio .specify/ en ${PROJECT_DIR}"
  echo ""
  echo "SOLUCION: Ejecuta primero el skill SDD para crear la estructura."
  echo "  bash scripts/init_sdd_project.sh ${PROJECT_DIR}"
  echo ""
  exit 1
fi

# Verificar constitution.md
if [ ! -f "${SPECIFY_DIR}/memory/constitution.md" ]; then
  echo "ADVERTENCIA: Falta .specify/memory/constitution.md"
  echo "  El executor funcionara, pero sin contexto de proyecto definido."
  echo ""
fi

# Listar features disponibles
echo "Features encontradas en ${SPECIFY_DIR}/specs/:"
echo ""

if [ -d "${SPECIFY_DIR}/specs" ]; then
  FEATURES=$(ls -d "${SPECIFY_DIR}/specs/"*/ 2>/dev/null | xargs -I {} basename {})
  if [ -z "${FEATURES}" ]; then
    echo "  (ninguna feature encontrada)"
    echo ""
    echo "Crea una feature con:"
    echo "  bash scripts/new_feature.sh 001 nombre-feature"
  else
    for feature in ${FEATURES}; do
      SPEC_OK="NO"
      PLAN_OK="NO"
      TASKS_OK="NO"
      [ -f "${SPECIFY_DIR}/specs/${feature}/spec.md" ] && SPEC_OK="OK"
      [ -f "${SPECIFY_DIR}/specs/${feature}/plan.md" ] && PLAN_OK="OK"
      [ -f "${SPECIFY_DIR}/specs/${feature}/tasks.md" ] && TASKS_OK="OK"
      echo "  - ${feature}"
      echo "    spec.md: ${SPEC_OK} | plan.md: ${PLAN_OK} | tasks.md: ${TASKS_OK}"
    done
  fi
else
  echo "  Directorio specs/ no existe aun."
  echo "  Crea una feature: bash scripts/new_feature.sh 001 nombre-feature"
fi

echo ""
echo "Listo. Para ejecutar el ciclo completo usa:"
echo "  bash scripts/run_full_sdd_cycle.sh [startup|enterprise] [feature-id]"
echo ""

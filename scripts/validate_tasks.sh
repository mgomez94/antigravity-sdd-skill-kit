#!/usr/bin/env bash
# validate_tasks.sh - Valida que un tasks.md cumple los requisitos mínimos SDD
# Uso: bash scripts/validate_tasks.sh <ruta/a/tasks.md>

set -e
TASKS_FILE=$1
ERRORS=0
WARNINGS=0

if [ -z "$TASKS_FILE" ] || [ ! -f "$TASKS_FILE" ]; then
  echo "Uso: bash scripts/validate_tasks.sh <ruta/a/tasks.md>"
  exit 1
fi

echo ""
echo "Validando tasks: $TASKS_FILE"
echo "-------------------------------------------"

if grep -qi "BLOCKER\|blocker" "$TASKS_FILE"; then
  echo "[OK] Tarea BLOCKER presente (migración/setup)"
else
  echo "[WARN] No se detectó tarea BLOCKER - considera una tarea de setup"
  WARNINGS=$((WARNINGS + 1))
fi

if grep -qi "T-[0-9]\+\|Tarea [0-9]\+" "$TASKS_FILE"; then
  echo "[OK] Tareas numeradas presentes"
else
  echo "[ERROR] No se detectaron tareas numeradas (T-001, T-002...)"
  ERRORS=$((ERRORS + 1))
fi

if grep -qi "Dep:\|Depende\|dependencia" "$TASKS_FILE"; then
  echo "[OK] Dependencias entre tareas documentadas"
else
  echo "[WARN] No se detectaron dependencias entre tareas"
  WARNINGS=$((WARNINGS + 1))
fi

if grep -qi "test\|prueba\|Test\|verificar" "$TASKS_FILE"; then
  echo "[OK] Tests incluidos en tareas"
else
  echo "[ERROR] No se detectaron tests en las tareas"
  ERRORS=$((ERRORS + 1))
fi

if grep -qi "[0-9]\+ min\|[0-9]\+ hora\|Tiempo" "$TASKS_FILE"; then
  echo "[OK] Estimaciones de tiempo presentes"
else
  echo "[WARN] No se detectaron estimaciones de tiempo"
  WARNINGS=$((WARNINGS + 1))
fi

if grep -qi "IMPLEMENTATION_NOTES\|documentación\|notas" "$TASKS_FILE"; then
  echo "[OK] Tarea de documentación final presente"
else
  echo "[WARN] No se detectó tarea de documentación final"
  WARNINGS=$((WARNINGS + 1))
fi

echo "-------------------------------------------"
echo "Errores: $ERRORS | Advertencias: $WARNINGS"
echo ""

if [ $ERRORS -gt 0 ]; then
  echo "RESULTADO: FALLO"
  exit 1
elif [ $WARNINGS -gt 0 ]; then
  echo "RESULTADO: PASA CON ADVERTENCIAS"
  exit 0
else
  echo "RESULTADO: PASA"
  exit 0
fi

#!/usr/bin/env bash
# validate_plan.sh - Valida que un plan.md cumple los requisitos mínimos SDD
# Uso: bash scripts/validate_plan.sh <ruta/a/plan.md>

set -e
PLAN_FILE=$1
ERRORS=0
WARNINGS=0

if [ -z "$PLAN_FILE" ] || [ ! -f "$PLAN_FILE" ]; then
  echo "Uso: bash scripts/validate_plan.sh <ruta/a/plan.md>"
  exit 1
fi

echo ""
echo "Validando plan: $PLAN_FILE"
echo "-------------------------------------------"

if grep -qi "Estado:" "$PLAN_FILE"; then
  echo "[OK] Campo 'Estado' presente"
else
  echo "[ERROR] Falta campo 'Estado'"
  ERRORS=$((ERRORS + 1))
fi

if grep -qi "resumen.*arquitect\|arquitect.*resumen\|arquitectónico" "$PLAN_FILE"; then
  echo "[OK] Resumen arquitectónico presente"
else
  echo "[ERROR] Falta resumen arquitectónico"
  ERRORS=$((ERRORS + 1))
fi

if grep -qi "modelo.*datos\|CREATE TABLE\|tabla\|database\|schema" "$PLAN_FILE"; then
  echo "[OK] Modelo de datos presente"
else
  echo "[WARN] No se detectó modelo de datos"
  WARNINGS=$((WARNINGS + 1))
fi

if grep -qi "GET\|POST\|PUT\|DELETE\|PATCH\|endpoint\|api\|ruta" "$PLAN_FILE"; then
  echo "[OK] Contratos de API presentes"
else
  echo "[WARN] No se detectaron contratos de API"
  WARNINGS=$((WARNINGS + 1))
fi

if grep -qi "decisión\|trade-off\|alternativa\|elección" "$PLAN_FILE"; then
  echo "[OK] Decisiones técnicas documentadas"
else
  echo "[WARN] No se detectaron decisiones técnicas documentadas"
  WARNINGS=$((WARNINGS + 1))
fi

if grep -qi "riesgo\|risk" "$PLAN_FILE"; then
  echo "[OK] Riesgos identificados"
else
  echo "[WARN] No se detectaron riesgos - considera agregar aunque sea 1"
  WARNINGS=$((WARNINGS + 1))
fi

if grep -qi "test\|prueba\|spec\|coverage" "$PLAN_FILE"; then
  echo "[OK] Estrategia de testing presente"
else
  echo "[ERROR] Falta estrategia de testing"
  ERRORS=$((ERRORS + 1))
fi

echo "-------------------------------------------"
echo "Errores: $ERRORS | Advertencias: $WARNINGS"
echo ""

if [ $ERRORS -gt 0 ]; then
  echo "RESULTADO: FALLO - Corrige los errores antes de continuar"
  exit 1
elif [ $WARNINGS -gt 0 ]; then
  echo "RESULTADO: PASA CON ADVERTENCIAS"
  exit 0
else
  echo "RESULTADO: PASA - El plan cumple los requisitos mínimos"
  exit 0
fi

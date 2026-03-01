#!/usr/bin/env bash
# =============================================================================
# validate_spec.sh
# Valida que una spec.md cumple los requisitos mínimos de SDD
# Uso: bash scripts/validate_spec.sh <ruta/a/spec.md>
# =============================================================================

set -e

SPEC_FILE=$1
ERRORS=0
WARNINGS=0

if [ -z "$SPEC_FILE" ]; then
  echo "Uso: bash scripts/validate_spec.sh <ruta/a/spec.md>"
  exit 1
fi

if [ ! -f "$SPEC_FILE" ]; then
  echo "ERROR: No se encuentra el archivo: $SPEC_FILE"
  exit 1
fi

echo ""
echo "Validando spec: $SPEC_FILE"
echo "-------------------------------------------"

# Check 1: Tiene estado
if grep -qi "Estado:" "$SPEC_FILE"; then
  echo "[OK] Campo 'Estado' presente"
else
  echo "[ERROR] Falta campo 'Estado'"
  ERRORS=$((ERRORS + 1))
fi

# Check 2: Tiene objetivo de negocio
if grep -qi "objetivo.*negocio\|objetivo de negocio" "$SPEC_FILE"; then
  echo "[OK] Sección 'Objetivo de Negocio' presente"
else
  echo "[ERROR] Falta sección 'Objetivo de Negocio'"
  ERRORS=$((ERRORS + 1))
fi

# Check 3: Tiene User Stories
if grep -qi "User Stor\|Historia\|Como.*quiero\|As a\|I want" "$SPEC_FILE"; then
  echo "[OK] User Stories presentes"
else
  echo "[ERROR] No se detectaron User Stories"
  ERRORS=$((ERRORS + 1))
fi

# Check 4: Tiene criterios GIVEN-WHEN-THEN
if grep -qi "GIVEN\|CUANDO\|DADO" "$SPEC_FILE"; then
  echo "[OK] Criterios GIVEN/WHEN/THEN presentes"
else
  echo "[ERROR] Faltan criterios GIVEN-WHEN-THEN"
  ERRORS=$((ERRORS + 1))
fi

# Check 5: Tiene requisitos no funcionales
if grep -qi "no funcional\|rendimiento\|seguridad\|performance\|security" "$SPEC_FILE"; then
  echo "[OK] Requisitos No Funcionales presentes"
else
  echo "[WARN] No se detectaron Requisitos No Funcionales"
  WARNINGS=$((WARNINGS + 1))
fi

# Check 6: Tiene casos borde
if grep -qi "caso.*borde\|edge case\|caso de error" "$SPEC_FILE"; then
  echo "[OK] Casos borde presentes"
else
  echo "[WARN] No se detectaron casos borde"
  WARNINGS=$((WARNINGS + 1))
fi

# Check 7: No tiene lenguaje vago
if grep -qi "debe ser rápido\|debe ser bueno\|lo más rápido posible\|cuando sea posible" "$SPEC_FILE"; then
  echo "[WARN] Detectado lenguaje vago (ej: 'debe ser rápido')"
  WARNINGS=$((WARNINGS + 1))
fi

# Check 8: Tiene dependencias documentadas
if grep -qi "dependencia\|dependency\|depend" "$SPEC_FILE"; then
  echo "[OK] Sección de dependencias presente"
else
  echo "[WARN] No se detectaron dependencias (puede estar bien si no hay ninguna)"
  WARNINGS=$((WARNINGS + 1))
fi

echo "-------------------------------------------"
echo "Errores: $ERRORS | Advertencias: $WARNINGS"
echo ""

if [ $ERRORS -gt 0 ]; then
  echo "RESULTADO: FALLO - Corrige los errores antes de continuar"
  exit 1
elif [ $WARNINGS -gt 0 ]; then
  echo "RESULTADO: PASA CON ADVERTENCIAS - Revisa las advertencias"
  exit 0
else
  echo "RESULTADO: PASA - La spec cumple los requisitos mínimos"
  exit 0
fi

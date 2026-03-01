#!/usr/bin/env bash
set -e

# choose_mode.sh
# Reads .specify/memory/constitution.md and suggests 'startup' or 'enterprise' mode.
# Usage: bash scripts/choose_mode.sh [--force startup|enterprise]

CONSTITUTION=".specify/memory/constitution.md"
FORCED_MODE="$1"

if [ -n "$FORCED_MODE" ]; then
  case "$FORCED_MODE" in
    startup|enterprise)
      echo "MODE: $FORCED_MODE (forced by argument)"
      echo "$FORCED_MODE" > .sdd_mode
      exit 0
      ;;
    *)
      echo "ERROR: Invalid mode '$FORCED_MODE'. Use 'startup' or 'enterprise'."
      exit 1
      ;;
  esac
fi

if [ ! -f "$CONSTITUTION" ]; then
  echo "WARNING: $CONSTITUTION not found. Defaulting to 'startup' mode."
  echo "startup" > .sdd_mode
  exit 0
fi

# Read keywords from constitution
ENTERPRISE_KEYWORDS=("compliance" "regulado" "SLA" "PCI" "HIPAA" "finanzas" "salud" "enterprise" "critico" "regulated" "critical" "multi-team")
STARTUP_KEYWORDS=("MVP" "prototipo" "experimento" "startup" "prototype" "experiment" "quick")

ENTERPRISE_SCORE=0
STARTUP_SCORE=0

for kw in "${ENTERPRISE_KEYWORDS[@]}"; do
  if grep -qi "$kw" "$CONSTITUTION"; then
    ENTERPRISE_SCORE=$((ENTERPRISE_SCORE + 1))
  fi
done

for kw in "${STARTUP_KEYWORDS[@]}"; do
  if grep -qi "$kw" "$CONSTITUTION"; then
    STARTUP_SCORE=$((STARTUP_SCORE + 1))
  fi
done

echo "=== Mode Detection ==="
echo "Startup signals:    $STARTUP_SCORE"
echo "Enterprise signals: $ENTERPRISE_SCORE"

if [ "$ENTERPRISE_SCORE" -gt "$STARTUP_SCORE" ]; then
  SUGGESTED_MODE="enterprise"
elif [ "$STARTUP_SCORE" -gt "$ENTERPRISE_SCORE" ]; then
  SUGGESTED_MODE="startup"
else
  SUGGESTED_MODE="startup"
  echo "Tie detected. Defaulting to 'startup'."
fi

echo "SUGGESTED MODE: $SUGGESTED_MODE"
echo "$SUGGESTED_MODE" > .sdd_mode
echo ""
echo "To override: bash scripts/choose_mode.sh startup  OR  bash scripts/choose_mode.sh enterprise"
echo "Active mode saved to: .sdd_mode"

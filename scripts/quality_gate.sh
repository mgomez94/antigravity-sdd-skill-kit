#!/usr/bin/env bash
set -e

# quality_gate.sh
# Verifies test coverage thresholds based on the active SDD mode (startup or enterprise).
# Usage: bash scripts/quality_gate.sh [startup|enterprise]
#
# Supports: Jest (JS/TS), pytest-cov (Python), or reads coverage from file.
# Falls back to a manual reminder if no coverage tool is detected.

MODE_ARG="$1"

# Determine mode
if [ -n "$MODE_ARG" ]; then
  MODE="$MODE_ARG"
elif [ -f ".sdd_mode" ]; then
  MODE=$(cat .sdd_mode)
else
  MODE="startup"
  echo "INFO: No mode specified or .sdd_mode found. Defaulting to 'startup'."
fi

echo "======================================"
echo "  SDD Quality Gate"
echo "  Mode: $MODE"
echo "======================================"
echo ""

# Set coverage thresholds per mode
case "$MODE" in
  startup)
    MIN_COVERAGE=70
    REQUIRE_E2E="yes"
    REQUIRE_INTEGRATION="yes"
    REQUIRE_LOAD="no"
    ;;
  enterprise)
    MIN_COVERAGE=85
    REQUIRE_E2E="yes"
    REQUIRE_INTEGRATION="yes"
    REQUIRE_LOAD="yes"
    ;;
  *)
    echo "ERROR: Unknown mode '$MODE'. Use 'startup' or 'enterprise'."
    exit 1
    ;;
esac

echo "Coverage threshold: ${MIN_COVERAGE}%"
echo "Require E2E tests:  $REQUIRE_E2E"
echo "Require Integration tests: $REQUIRE_INTEGRATION"
echo "Require Load tests: $REQUIRE_LOAD"
echo ""

FAILED=0

# Try to detect and run coverage
echo "[1/4] Running test suite and checking coverage..."

if [ -f "package.json" ]; then
  # Node/JS project
  if command -v npx &>/dev/null && grep -q '"jest"\|"vitest"' package.json 2>/dev/null; then
    echo "  Detected: Node.js project (Jest/Vitest)"
    # Run tests with coverage - exits with non-zero if coverage below threshold
    COVERAGE_THRESHOLD="{\"global\":{\"lines\":${MIN_COVERAGE}}}"
    npx jest --coverage --coverageThreshold="$COVERAGE_THRESHOLD" 2>&1 | tail -20 || {
      echo "  FAIL: Tests did not pass or coverage below ${MIN_COVERAGE}%."
      FAILED=$((FAILED + 1))
    }
  else
    echo "  INFO: package.json found but Jest/Vitest not detected. Skipping automated coverage check."
    echo "  ACTION REQUIRED: Run your test suite manually and verify coverage >= ${MIN_COVERAGE}%."
  fi
elif [ -f "pyproject.toml" ] || [ -f "setup.py" ] || [ -f "requirements.txt" ]; then
  # Python project
  if command -v pytest &>/dev/null; then
    echo "  Detected: Python project (pytest)"
    COV_FAIL_UNDER="--cov-fail-under=${MIN_COVERAGE}"
    pytest --cov=. $COV_FAIL_UNDER 2>&1 | tail -20 || {
      echo "  FAIL: Tests did not pass or coverage below ${MIN_COVERAGE}%."
      FAILED=$((FAILED + 1))
    }
  else
    echo "  INFO: Python project detected but pytest not found. Skipping automated coverage check."
    echo "  ACTION REQUIRED: Run your test suite manually and verify coverage >= ${MIN_COVERAGE}%."
  fi
else
  echo "  INFO: No recognized project type detected."
  echo "  ACTION REQUIRED: Run your test suite manually and verify coverage >= ${MIN_COVERAGE}%."
fi
echo ""

# E2E test check
echo "[2/4] E2E tests check (mode: $MODE)..."
if [ "$REQUIRE_E2E" = "yes" ]; then
  if [ -d "cypress" ] || [ -d "e2e" ] || [ -d "tests/e2e" ] || find . -name "*.spec.ts" -path "*/e2e/*" 2>/dev/null | grep -q .; then
    echo "  OK: E2E test directory found. Run E2E tests before marking DONE."
    echo "  ACTION REQUIRED: Verify E2E tests pass in your local/staging environment."
  else
    echo "  WARNING: No E2E test directory detected. E2E tests are required in $MODE mode."
    FAILED=$((FAILED + 1))
  fi
fi
echo ""

# Integration test check
echo "[3/4] Integration tests check..."
if [ "$REQUIRE_INTEGRATION" = "yes" ]; then
  if find . -name "*.integration.*" -o -name "*.int.test.*" -o -path "*/integration/*" 2>/dev/null | grep -q .; then
    echo "  OK: Integration test files detected."
    echo "  ACTION REQUIRED: Verify integration tests pass."
  else
    echo "  INFO: No integration test files detected automatically."
    echo "  ACTION REQUIRED: Ensure integration tests exist and pass for $MODE mode."
  fi
fi
echo ""

# Load test check (enterprise only)
echo "[4/4] Load/Performance tests check..."
if [ "$REQUIRE_LOAD" = "yes" ]; then
  if find . -name "*.load.*" -o -path "*/load-tests/*" -o -path "*/performance/*" 2>/dev/null | grep -q .; then
    echo "  OK: Load test files detected."
    echo "  ACTION REQUIRED: Verify load tests pass with acceptable metrics."
  else
    echo "  WARNING: No load test files detected. Load/performance tests are required in enterprise mode."
    echo "  ACTION REQUIRED: Add load tests (e.g., k6, Locust, Artillery) before go-live."
    FAILED=$((FAILED + 1))
  fi
else
  echo "  INFO: Load tests not required in $MODE mode. Skipped."
fi
echo ""

# Summary
echo "======================================"
if [ "$FAILED" -gt 0 ]; then
  echo "  RESULT: Quality gate FAILED ($FAILED issue(s))."
  echo "  Fix issues above before marking feature as DONE."
  echo "  See: config/modes.yaml for thresholds per mode."
  echo "======================================"
  exit 1
else
  echo "  RESULT: Quality gate PASSED for mode: $MODE."
  echo "  Remember to also run: bash scripts/security_checklist.sh"
  echo "======================================"
  exit 0
fi

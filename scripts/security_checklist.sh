#!/usr/bin/env bash
set -e

# security_checklist.sh
# Scans the codebase for common security anti-patterns and reminds the
# agent/developer to review the full security baseline before marking work DONE.
# Usage: bash scripts/security_checklist.sh [--path ./src]

SCAN_PATH="${1:-./}"
FAILED=0

echo "======================================"
echo "  SDD Security Checklist"
echo "  Scanning: $SCAN_PATH"
echo "======================================"
echo ""

# 1. Hardcoded secrets
echo "[1/7] Checking for hardcoded secrets..."
SECRET_PATTERNS=("API_KEY=" "SECRET=" "PASSWORD=" "TOKEN=" "PRIVATE_KEY=" "DB_PASS=")
for pat in "${SECRET_PATTERNS[@]}"; do
  RESULTS=$(grep -rn --include="*.js" --include="*.ts" --include="*.py" --include="*.sh" --include="*.env" "$pat" "$SCAN_PATH" 2>/dev/null | grep -v "#" | grep -v ".env.example" | grep -v "node_modules" || true)
  if [ -n "$RESULTS" ]; then
    echo "  WARNING: Potential hardcoded secret pattern '$pat' found:"
    echo "$RESULTS" | head -5
    FAILED=$((FAILED + 1))
  fi
done
[ $FAILED -eq 0 ] && echo "  OK: No obvious hardcoded secrets found."
echo ""

# 2. TODO SECURITY markers
echo "[2/7] Checking for TODO SECURITY markers..."
TODO_SEC=$(grep -rn "TODO SECURITY\|FIXME SECURITY\|HACK SECURITY" "$SCAN_PATH" --include="*.js" --include="*.ts" --include="*.py" --include="*.md" 2>/dev/null | grep -v "node_modules" || true)
if [ -n "$TODO_SEC" ]; then
  echo "  WARNING: Unresolved security TODOs found:"
  echo "$TODO_SEC" | head -10
  FAILED=$((FAILED + 1))
else
  echo "  OK: No unresolved security TODOs."
fi
echo ""

# 3. console.log of sensitive data
echo "[3/7] Checking for dangerous console.log / print patterns..."
LOG_PATTERNS=$(grep -rn "console.log.*password\|console.log.*token\|console.log.*secret\|print.*password\|print.*token" "$SCAN_PATH" --include="*.js" --include="*.ts" --include="*.py" 2>/dev/null | grep -v "node_modules" || true)
if [ -n "$LOG_PATTERNS" ]; then
  echo "  WARNING: Possible sensitive data logging detected:"
  echo "$LOG_PATTERNS" | head -5
  FAILED=$((FAILED + 1))
else
  echo "  OK: No obvious sensitive data logging."
fi
echo ""

# 4. SQL concatenation patterns
echo "[4/7] Checking for SQL injection risk patterns..."
SQL_CONCAT=$(grep -rn "\"SELECT.*\+\|query.*\+.*req\.body\|query.*\+.*req\.params\|execute.*\+" "$SCAN_PATH" --include="*.js" --include="*.ts" --include="*.py" 2>/dev/null | grep -v "node_modules" || true)
if [ -n "$SQL_CONCAT" ]; then
  echo "  WARNING: Possible SQL injection risk (string concatenation in queries):"
  echo "$SQL_CONCAT" | head -5
  FAILED=$((FAILED + 1))
else
  echo "  OK: No obvious SQL concatenation patterns found."
fi
echo ""

# 5. eval() usage
echo "[5/7] Checking for dangerous eval() usage..."
EVAL_USE=$(grep -rn "eval(" "$SCAN_PATH" --include="*.js" --include="*.ts" --include="*.py" 2>/dev/null | grep -v "node_modules" || true)
if [ -n "$EVAL_USE" ]; then
  echo "  WARNING: eval() usage found (potential code injection):"
  echo "$EVAL_USE" | head -5
  FAILED=$((FAILED + 1))
else
  echo "  OK: No eval() usage detected."
fi
echo ""

# 6. Disabled SSL/TLS
echo "[6/7] Checking for disabled SSL/TLS verification..."
SSL_DISABLED=$(grep -rn "rejectUnauthorized.*false\|verify=False\|ssl_verify.*false" "$SCAN_PATH" --include="*.js" --include="*.ts" --include="*.py" 2>/dev/null | grep -v "node_modules" || true)
if [ -n "$SSL_DISABLED" ]; then
  echo "  WARNING: SSL/TLS verification appears to be disabled:"
  echo "$SSL_DISABLED" | head -5
  FAILED=$((FAILED + 1))
else
  echo "  OK: No disabled SSL/TLS verification found."
fi
echo ""

# 7. Manual security baseline reminder
echo "[7/7] Manual checklist reminder (verify these manually):"
echo "  [ ] Authentication: All sensitive endpoints require auth"
echo "  [ ] Authorization: Role checks enforced server-side, not client-side"
echo "  [ ] HTTPS/TLS enforced in all external environments"
echo "  [ ] CORS configured to known origins only"
echo "  [ ] CSP headers configured in frontend"
echo "  [ ] CSRF protection in place (SameSite cookies / CSRF tokens)"
echo "  [ ] Rate limiting on login, password reset, and critical endpoints"
echo "  [ ] Input validation with schema validators on all user inputs"
echo "  [ ] Sensitive data NOT stored in logs, URLs, or localStorage unnecessarily"
echo "  [ ] Dependency audit run (npm audit / pip-audit / equivalent)"
echo "  See: config/security_baseline.md for full details."
echo ""

# Summary
echo "======================================"
if [ "$FAILED" -gt 0 ]; then
  echo "  RESULT: $FAILED automated check(s) FAILED."
  echo "  Review warnings above and fix before marking feature as DONE."
  echo "======================================"
  exit 1
else
  echo "  RESULT: All automated checks PASSED."
  echo "  Still review manual checklist above before marking DONE."
  echo "======================================"
  exit 0
fi

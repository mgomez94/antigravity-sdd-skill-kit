#!/usr/bin/env bash
# =============================================================================
# init_sdd_project.sh
# Inicializa la estructura SDD (.specify/) en el proyecto actual
# Uso: bash scripts/init_sdd_project.sh
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"

echo ""
echo "==================================================="
echo "  SDD Skill Kit - Inicialización de Proyecto"
echo "==================================================="
echo ""

# Crear estructura de directorios
echo "[1/4] Creando estructura .specify/..."
mkdir -p .specify/memory
mkdir -p .specify/specs
mkdir -p .specify/templates
echo "  OK: .specify/ creada"

# Copiar constitution base si no existe
echo "[2/4] Creando constitution.md base..."
if [ ! -f .specify/memory/constitution.md ]; then
  cat > .specify/memory/constitution.md << 'EOF'
# Constitución del Proyecto

**Proyecto**: [NOMBRE DEL PROYECTO]
**Fecha de creación**: $(date +%Y-%m-%d)
**Stack**: React + TypeScript | Node.js + Express | PostgreSQL | Docker

---

## 1. Tipo de Proyecto

[Describe qué es este proyecto: web app, API, microservicio, etc.]

## 2. Stack Tecnológico

### Frontend
- Framework: React + TypeScript
- Estilos: TailwindCSS
- Estado: React Query + Zustand
- Testing: Vitest + Testing Library

### Backend
- Runtime: Node.js 20+
- Framework: Express + TypeScript
- ORM: Prisma
- Testing: Jest + Supertest

### Base de Datos
- Principal: PostgreSQL 16
- Migraciones: Prisma Migrate

### Infraestructura
- Contenedores: Docker + Docker Compose
- CI/CD: GitHub Actions

## 3. Principios Arquitectónicos

- Arquitectura en capas: Routes -> Controllers -> Services -> Repositories
- Separación estricta frontend/backend
- API RESTful con versionado (/api/v1/)
- Autenticación con JWT

## 4. Estándares de Código

- Linting: ESLint + Prettier
- Commits: Conventional Commits (feat/fix/chore/docs)
- Cobertura de tests: mínimo 80% en código nuevo
- Code review requerido para merge a main

## 5. Restricciones de Seguridad

- Nunca exponer variables de entorno en código
- Todas las rutas privadas requieren autenticación JWT
- Inputs validados antes de procesamiento
- Logs no deben incluir datos sensibles (passwords, tokens)

## 6. Restricciones de Rendimiento

- API response time: < 200ms p95
- Frontend LCP: < 2.5s
- N+1 queries prohibidos
EOF
  echo "  OK: .specify/memory/constitution.md creada"
else
  echo "  SKIP: constitution.md ya existe"
fi

# Copiar templates
echo "[3/4] Copiando templates..."
if [ -f "$SKILL_DIR/references/02_spec_templates.md" ]; then
  cp "$SKILL_DIR/references/02_spec_templates.md" .specify/templates/spec_template.md
  cp "$SKILL_DIR/references/03_plan_templates.md" .specify/templates/plan_template.md
  cp "$SKILL_DIR/references/04_tasks_templates.md" .specify/templates/tasks_template.md
  echo "  OK: Templates copiados a .specify/templates/"
else
  echo "  WARN: Referencias del skill no encontradas en $SKILL_DIR"
fi

# Crear .gitignore para .specify si no existe
echo "[4/4] Configurando .gitignore..."
if [ ! -f .specify/.gitignore ]; then
  cat > .specify/.gitignore << 'EOF'
# No ignorar nada - los artefactos SDD se versifican
# Puedes agregar aquí archivos temporales o de trabajo
*.tmp
*.draft
EOF
  echo "  OK: .specify/.gitignore creado"
fi

echo ""
echo "==================================================="
echo "  Estructura SDD inicializada exitosamente!"
echo "==================================================="
echo ""
echo "Próximos pasos:"
echo "  1. Edita .specify/memory/constitution.md con los datos de tu proyecto"
echo "  2. Crea tu primera feature: bash scripts/new_feature.sh 001 nombre-feature"
echo "  3. Sigue el flujo SDD: spec -> plan -> tasks -> implement"
echo ""

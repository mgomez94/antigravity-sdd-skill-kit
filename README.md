# Antigravity SDD Skill Kit

> Guía profesional completa de **Specs Driven Development (SDD)** para proyectos con stack React + TypeScript / Node.js + Express / PostgreSQL.

## Qué es este repositorio

Este kit proporciona todo lo necesario para implementar SDD (Desarrollo Guiado por Especificaciones) de forma profesional en tus proyectos. Incluye:

- **SKILL.md** — Guía maestra del método SDD con Antigravity
- **Referencias** — 6 documentos de referencia detallados
- **Scripts** — 6 scripts de automatización para el ciclo SDD completo
- **Ejemplos** — 2 proyectos de ejemplo con estructura SDD completa

## Estructura del Repositorio

```
antigravity-sdd-skill-kit/
├── SKILL.md                          # Guía maestra SDD
├── references/
│   ├── 01_sdd_principles.md           # Principios fundamentales SDD
│   ├── 02_spec_templates.md           # Plantillas para SPEC
│   ├── 03_plan_templates.md           # Plantillas para PLAN
│   ├── 04_tasks_templates.md          # Plantillas para TASKS
│   ├── 05_quality_gates.md            # Gates de calidad por fase
│   └── 06_antigravity_integration.md  # Integración con Antigravity
├── scripts/
│   ├── init_sdd_project.sh            # Inicializar proyecto SDD
│   ├── new_feature.sh                 # Crear nueva feature SDD
│   ├── validate_spec.sh               # Validar SPEC antes de continuar
│   ├── validate_plan.sh               # Validar PLAN
│   ├── validate_tasks.sh              # Validar TASKS
│   └── run_full_sdd_cycle.sh          # Ejecutar ciclo SDD completo
└── examples/
    ├── todo-app/
    │   └── .specify/
    │       ├── memory/
    │       │   └── constitution.md    # Constitución del proyecto
    │       ├── spec.md               # Especificación funcional
    │       ├── plan.md               # Plan de arquitectura
    │       └── tasks.md              # Backlog de tareas
    └── ecommerce-cart/
        └── .specify/
            ├── memory/
            │   └── constitution.md    # Constitución del proyecto
            ├── spec.md               # Especificación funcional
            ├── plan.md               # Plan de arquitectura
            └── tasks.md              # Backlog de tareas
```

## El Método SDD en 4 Fases

### Fase 1: SPEC (Especificación)
Antes de escribir código, documenta:
- Objetivo del proyecto/feature
- Requerimientos funcionales (RF-001, RF-002...)
- Criterios de aceptación en formato Dado/Cuando/Entonces
- Restricciones técnicas y fuera de alcance

### Fase 2: PLAN (Arquitectura)
Diseña antes de implementar:
- Estructura de carpetas y archivos
- Esquema de base de datos
- Decisiones técnicas justificadas
- Fases de implementación con estimaciones

### Fase 3: TASKS (Backlog)
Desglosa en tareas accionables:
- Cada tarea con estado, estimación y checklist
- Organizadas en sprints
- Definición de Hecho (DoD) clara

### Fase 4: EXECUTE (Implementación)
Desarrolla guiado por los documentos:
- El código implementa exactamente lo especificado
- Cada tarea completada cumple su checklist
- Los quality gates validan el avance

## Uso Rápido

### Inicializar un nuevo proyecto SDD
```bash
bash scripts/init_sdd_project.sh mi-proyecto
```

### Crear una nueva feature con estructura SDD
```bash
bash scripts/new_feature.sh autenticacion-usuarios
```

### Validar documentos SDD antes de continuar
```bash
bash scripts/validate_spec.sh .specify/spec.md
bash scripts/validate_plan.sh .specify/plan.md
bash scripts/validate_tasks.sh .specify/tasks.md
```

### Ejecutar el ciclo SDD completo
```bash
bash scripts/run_full_sdd_cycle.sh
```

## La Carpeta `.specify`

Cada proyecto o feature SDD tiene una carpeta `.specify` con esta estructura:

```
.specify/
├── memory/
│   └── constitution.md   # Principios, restricciones y contexto permanente
├── spec.md              # Qué construir (funcional)
├── plan.md              # Cómo construirlo (técnico)
└── tasks.md             # Cuándo y quién (backlog)
```

## Stack Base

| Capa | Tecnología |
|---|---|
| Frontend | React 18 + TypeScript + Vite |
| Estado | Redux Toolkit + React Query |
| Backend | Node.js + Express + TypeScript |
| Base de datos | PostgreSQL + Prisma ORM |
| Autenticación | JWT (httpOnly cookies) |
| Tests | Jest (backend) + Vitest (frontend) |
| Estilos | TailwindCSS |
| Pagos | Stripe |

## Principios Fundamentales

1. **Especificación primero** — Nunca codificar sin SPEC aprobada
2. **Arquitectura antes que código** — El PLAN previene el retrabajo
3. **Tareas atómicas** — Cada TASK es verificable independientemente
4. **Memory persistente** — La constitution.md mantiene el contexto del proyecto
5. **Quality gates** — Cada fase tiene criterios de salida claros

## Ejemplos Incluidos

### Todo App
Aplicación de tareas con autenticación JWT, CRUD completo y persistencia en PostgreSQL. Ideal para aprender el flujo SDD básico.

### Ecommerce Cart
Módulo de carrito de compras con catálogo, cupones, checkout con Stripe y gestión atómica de inventario. Ejemplo de SDD en un contexto de negocio real.

## Contribuir

1. Fork del repositorio
2. Crea tu branch: `git checkout -b feature/mi-contribucion`
3. Sigue el ciclo SDD (SPEC → PLAN → TASKS → EXECUTE)
4. Pull Request con descripción de cambios

---

**Autor:** mgomez94 | **Stack:** React + TypeScript / Node.js + Express / PostgreSQL

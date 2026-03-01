# Skill: Spec-Driven Development (SDD Senior Kit)

## Propósito
Convertir trabajo "vibe coding" en **desarrollo senior guiado por especificaciones**, usando un flujo SDD completo:

**Constitution → Specification → Clarification → Plan → Tasks → Implementation**

El agente debe usar este skill siempre que el usuario:
- Pida crear, extender o refactorizar una funcionalidad no trivial.
- Quiera usar "spec-driven", "spec kit", "SDD" o "trabajar con especificaciones".
- Necesite asegurar calidad y trazabilidad en el desarrollo.

## Filosofía
- Primero intención (especificación), luego código.
- Especificaciones revisables por humanos, breves y testables.
- Cada fase tiene salida clara y checklist de calidad.
- Optimizado para Antigravity: usa AGENTS.md, Antigravity.md y artefactos de runtime.

## Stack Base por Defecto (Constitución)
- **Frontend**: React + TypeScript
- **Backend**: Node.js + Express
- **Base de datos**: PostgreSQL
- **Infraestructura**: Docker
- **Automatización**: n8n

---

## Flujo de Trabajo

### Fase 0 – Constitución (opcional si ya existe)
1. Pregunta al usuario por tipo de proyecto, stack preferido, prioridades.
2. Crea o actualiza `.specify/memory/constitution.md`.
3. Pide confirmación antes de usar como base.

### Fase 1 – Specification (`spec.md`)
1. Lee el contexto del repositorio (README, Antigravity.md, AGENTS.md).
2. Pregunta al usuario por objetivo de negocio, escenario principal, restricciones.
3. Crea `.specify/specs/NNN-feature/spec.md` usando `/references/02_spec_templates.md`.
4. Asegura user stories GIVEN–WHEN–THEN, NFRs, edge cases.
5. Muestra la spec y espera feedback.

### Fase 2 – Clarification (opcional)
1. Si hay ambigüedades, genera lista de preguntas concretas.
2. Integra respuestas en `spec.md`.
3. Marca como `Estado: Approved`.

### Fase 3 – Plan (`plan.md`)
1. Usa constitución + spec aprobada + contexto del repo.
2. Diseña arquitectura, modelo de datos, contratos de API, trade-offs.
3. Crea `plan.md` usando `/references/03_plan_templates.md`.
4. Verifica que cada requisito de spec.md esté cubierto.

### Fase 4 – Tasks (`tasks.md`)
1. Descompone el plan en tareas de 30-60 minutos.
2. Añade dependencias, paralelismo [P], rutas de archivos, tests TDD.
3. Crea `tasks.md` usando `/references/04_tasks_templates.md`.

### Fase 5 – Implementation
1. Implementa tareas en orden usando Antigravity.
2. Escribe tests primero (TDD), ejecuta y corrige.
3. Usa `/scripts/validate_*.sh` para verificar.
4. Genera `IMPLEMENTATION_NOTES.md` con resumen.

---

## Quality Gates

| Transición | Verificación requerida |
|---|---|
| Spec → Plan | GIVEN-WHEN-THEN completos + NFRs definidos |
| Plan → Tasks | Arquitectura consistente con constitución + riesgos identificados |
| Tasks → Implementation | Tareas cubren toda la spec, sin huecos |

---

## Anti-Patrones a Evitar
- **Specification Theater**: specs larguísimas que nadie lee.
- **Vaguedad**: "el sistema debe ser rápido".
- Ignorar la constitución del proyecto.
- Reescribir todo el código sin necesidad.

## Patrones a Fomentar
- Specs de 3-5 páginas máximo.
- Ejemplos concretos de entrada/salida.
- Granularidad SDD: módulos pequeños y cohesivos.

---

## Comandos Sugeridos para el Usuario
- `"Usa el skill SDD para diseñar esta feature antes de escribir código."`
- `"Corre el flujo completo SDD para añadir [feature]."`
- `"Solo quiero Specification + Plan para esta idea, sin Implementation todavía."`
- `"Inicializa el proyecto SDD con el script init_sdd_project.sh"`

---

## Estructura de Archivos del Skill

```
antigravity-sdd-skill-kit/
  SKILL.md
  references/
    01_sdd_principles.md
    02_spec_templates.md
    03_plan_templates.md
    04_tasks_templates.md
    05_quality_gates.md
    06_antigravity_integration.md
  examples/
    todo-app/
      .specify/
        memory/constitution.md
        specs/001-todo-feature/spec.md
        specs/001-todo-feature/plan.md
        specs/001-todo-feature/tasks.md
    ecommerce-cart/
      .specify/
        memory/constitution.md
        specs/001-cart/spec.md
  scripts/
    init_sdd_project.sh
    new_feature.sh
    validate_spec.sh
    validate_plan.sh
    validate_tasks.sh
    run_full_sdd_cycle.sh
```

---

## Referencias
- [GitHub Spec Kit](https://github.com/github/spec-kit)
- [SDD Pilot para Antigravity](https://www.reddit.com/r/google_antigravity/comments/1rfm66i/)
- [Spec Kit Antigravity Skills](https://github.com/compnew2006/Spec-Kit-Antigravity-Skills)
- [SDD Codelab oficial Google](https://codelabs.developers.google.com/codelabs/getting-started-with-spec-driven-development-in-antigravity)

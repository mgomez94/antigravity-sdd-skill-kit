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
- **La seguridad es obligatoria en todas las fases, no negociable.**

---

## Flujo de Trabajo

### Fase 0 – Constitución (opcional si ya existe)
1. Pregunta al usuario por:
   - Tipo de proyecto, stack preferido, prioridades (calidad, velocidad, coste).
   - Estándares de seguridad, rendimiento y testing.
2. Crea o actualiza `.specify/memory/constitution.md` usando `/references/01_sdd_principles.md`.
3. Pide confirmación al usuario antes de usar esa constitución como base.

### Fase 1 – Specification (`spec.md`)
1. Lee el contexto del repositorio (README, Antigravity.md, AGENTS.md, docs relevantes).
2. Pregunta al usuario por:
   - Objetivo de negocio.
   - Escenario de uso principal.
   - Restricciones importantes (plazo, tech, seguridad).
3. Crea `.specify/specs/NNN-feature/spec.md` basándote en:
   - `/references/02_spec_templates.md`
   - Ejemplos en `/examples/*/.specify/specs/*/spec.md`
4. Asegura:
   - User stories con formato GIVEN–WHEN–THEN.
   - Requisitos no funcionales explícitos (perf, seguridad, escalabilidad).
   - Edge cases y dependencias listadas.
5. Muestra la spec al usuario y espera feedback antes de seguir.

### Fase 2 – Clarification (opcional)
1. Si hay ambigüedades, genera una lista de preguntas concretas.
2. Integra las respuestas en `spec.md`.
3. Marca la spec como `Estado: Approved` cuando esté lista.

### Fase 3 – Plan Técnico (`plan.md`)

**Objetivo**: Convertir la especificación funcional en una estrategia técnica ejecutable, con decisiones de arquitectura, datos, APIs y despliegue.

**Entradas**:
- `.specify/memory/constitution.md`
- `.specify/specs/NNN-feature/spec.md`
- Contexto del proyecto (código existente, README, etc.)

**Salidas**:
- `.specify/specs/NNN-feature/plan.md` con:
  - Arquitectura propuesta (componentes, capas, límites)
  - Modelo de datos / esquemas
  - Contratos de API / interfaces
  - Decisiones técnicas y trade-offs
  - Riesgos y mitigaciones
  - Estrategia de testing y despliegue

#### 3.1 Pasos generales (entorno neutral)
1. Leer `constitution.md` para entender stack, estándares de calidad, seguridad y restricciones.
2. Leer `spec.md` para identificar user stories, flujos principales y requisitos no funcionales.
3. Diseñar plan técnico que cubra arquitectura, modelo de datos, contratos de APIs, testing y despliegue.

#### 3.2 Si estoy corriendo dentro de Antigravity (ventaja arquitectónica)

Cuando este skill se ejecute en Antigravity, el agente **DEBE** apoyarse en las skills de Antigravity Kit para elevar la calidad del plan:

- **`antigravity-kit/architecture`** para:
  - Explorar alternativas arquitectónicas (monolito, modular monolith, servicios, colas, etc.)
  - Documentar decisiones como ADRs (Architecture Decision Records)
  - Evaluar trade-offs entre simplicidad y robustez según el modo (startup vs enterprise)

- **`antigravity-kit/database-design`** para:
  - Proponer modelos de datos alineados con la spec
  - Identificar claves primarias, relaciones y constraints

- **`antigravity-kit/api-patterns`** para:
  - Definir contratos HTTP/REST/GraphQL claros
  - Especificar códigos de estado, payloads y errores

- **`antigravity-kit/deployment-procedures`** para:
  - Sugerir estrategias de despliegue acordes al tipo de proyecto (startup MVP vs enterprise)
  - Definir entornos (dev/stage/prod) y pipelines básicos

El resultado debe quedar plasmado en `plan.md` de forma que:
- Cualquier desarrollador pueda entender la arquitectura propuesta.
- El Fullstack SDD Executor y otros agentes puedan seguir este plan paso a paso.
- Las decisiones de arquitectura sean trazables y justificadas.

#### 3.3 Checklist de aceptación del plan
Antes de dar por terminado `plan.md`, verificar:

- [ ] Se cubren todos los requisitos de `spec.md`
- [ ] Hay un diagrama o descripción clara de arquitectura
- [ ] El modelo de datos está descrito al menos a nivel de tablas/entidades
- [ ] Los contratos de API están definidos (rutas, métodos, payloads, errores)
- [ ] Se mencionan riesgos técnicos y mitigaciones
- [ ] Hay una estrategia mínima de testing y despliegue
- [ ] **Si se ejecutó en Antigravity**, se aprovecharon las skills de arquitectura, BD, API y despliegue
- [ ] El usuario o stakeholder técnico ha revisado y aprobado el plan

### Fase 4 – Tasks (`tasks.md`)
1. Descompone el plan en tareas de 30–60 minutos.
2. Añade:
   - Dependencias.
   - Marcadores de paralelismo (ej: `[P]`).
   - Rutas de archivos concretas.
   - Tests incluidos (TDD) por tarea.
3. Crea `tasks.md` usando `/references/04_tasks_templates.md`.
4. Asegura que cada criterio de aceptación de `spec.md` tenga al menos una tarea asociada.

### Fase 5 – Implementation
1. Usa Antigravity (terminal, browser, runtime) para implementar tareas en orden.
2. Para cada etapa:
   - Escribe tests primero (cuando aplique).
   - Ejecuta tests y corrige fallos.
   - Respeta estándares de la constitución.
3. Usa `/scripts/validate_*.sh` para verificar spec, plan, tasks.
4. Ejecuta `/scripts/security_checklist.sh` antes de marcar cualquier tarea como DONE.
5. Ejecuta `/scripts/quality_gate.sh [startup|enterprise]` al completar la feature.
6. Genera un breve `IMPLEMENTATION_NOTES.md` con:
   - Qué se hizo.
   - Skills de Antigravity Kit usados.
   - Desviaciones respecto a spec/plan (si las hubo).
   - Pendientes.

---

## Quality Gates

Antes de avanzar entre fases, el agente DEBE verificar:

- **De Specification a Plan**:
  - Criterios GIVEN–WHEN–THEN completos.
  - Requisitos no funcionales definidos.
- **De Plan a Tasks**:
  - Arquitectura consistente con la constitución.
  - Riesgos identificados y mitigación básica.
  - Si en Antigravity: skills de arquitectura del kit fueron usados.
- **De Tasks a Implementation**:
  - Tareas cubren toda la spec.
  - No hay huecos evidentes.
- **Al completar Implementation**:
  - `security_checklist.sh` PASSED.
  - `quality_gate.sh` PASSED con umbral correcto según modo.

---

## Modos de Operación

Este skill trabaja en dos modos definidos en `/config/modes.yaml`:

- **`startup`**: Velocidad y time-to-market. Cobertura >= 70%, E2E + Integration obligatorios.
- **`enterprise`**: Robustez, compliance, seguridad profunda. Cobertura >= 85%, E2E + Integration + Load obligatorios.

Usa `bash scripts/choose_mode.sh` para detectar y fijar el modo automáticamente.

**En ambos modos la seguridad es obligatoria y no negociable.** Ver `/config/security_baseline.md`.

---

## Patrones y Anti-Patrones

Evitar:
- "Specification Theater": specs larguísimas que nadie lee.
- Especificaciones vagas ("el sistema debe ser rápido").
- Ignorar la constitución del proyecto.
- Reescribir todo el código sin necesidad.
- Omitir checks de seguridad bajo presión de tiempo.

Fomentar:
- Specs de 3–5 páginas máximo.
- Ejemplos concretos de entrada/salida.
- Pensar en módulos pequeños.
- Usar skills de arquitectura de Antigravity Kit en la fase de Plan.
- Documentar decisiones técnicas como ADRs en `plan.md`.

---

## Comandos sugeridos para el usuario

- `"Usa el skill de SDD para diseñar esta feature antes de escribir código."`
- `"Corre el flujo completo SDD para añadir [feature]."`
- `"Solo quiero Specification + Plan para esta idea, sin Implementation todavía."`
- `"Detecta el modo de este proyecto y aplica el quality gate correspondiente."`
- `"Verifica la seguridad del código con el baseline antes de hacer merge."`

---

## Scripts disponibles

| Script | Uso |
|--------|-----|
| `scripts/init_sdd_project.sh` | Inicializa estructura `.specify/` en el proyecto |
| `scripts/new_feature.sh NNN slug` | Crea carpeta + templates para nueva feature |
| `scripts/choose_mode.sh [startup\|enterprise]` | Detecta o fija modo activo |
| `scripts/validate_spec.sh` | Valida estructura de `spec.md` |
| `scripts/validate_plan.sh` | Valida estructura de `plan.md` |
| `scripts/validate_tasks.sh` | Valida estructura de `tasks.md` |
| `scripts/security_checklist.sh` | Escanea anti-patrones de seguridad |
| `scripts/quality_gate.sh [modo]` | Verifica cobertura y calidad según modo |
| `scripts/run_full_sdd_cycle.sh` | Ejecuta ciclo SDD completo |
| `scripts/init_from_sdd.sh` | Inicializa proyecto desde artefactos SDD existentes |

---

## Referencias

- `/references/01_sdd_principles.md` — Principios y fundamentos SDD
- `/references/02_spec_templates.md` — Templates de especificación
- `/references/03_plan_templates.md` — Templates de plan técnico (incluye sección Antigravity)
- `/references/04_tasks_templates.md` — Templates de tasks
- `/references/05_quality_gates.md` — Gates de calidad detallados
- `/references/06_antigravity_integration.md` — Integración completa con Antigravity Kit
- `/config/security_baseline.md` — Baseline de seguridad obligatorio
- `/config/modes.yaml` — Configuración de modos startup/enterprise
- `/workflows/startup_full_cycle.md` — Workflow completo modo startup
- `/workflows/enterprise_full_cycle.md` — Workflow completo modo enterprise

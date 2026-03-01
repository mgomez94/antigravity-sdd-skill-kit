---
name: fullstack-sdd-executor
version: 1.0.0
description: >
  Orquesta el ciclo completo de desarrollo (frontend, backend, testing, DevOps)
  a partir de artefactos SDD (.specify/*), usando Antigravity Kit para ejecutar
  como un fullstack senior, en modo startup o enterprise. La seguridad es
  obligatoria en ambos modos.
---

# Fullstack SDD Executor

## Propósito

Este skill conecta **Spec-Driven Development (SDD)** con las **capacidades técnicas de Antigravity Kit** para ejecutar el ciclo completo de desarrollo:

```
Constitution → Specification → Plan → Tasks → Implementation → Test → Deploy
```

El agente que use este skill debe:

1. Leer y respetar los artefactos SDD existentes (`constitution.md`, `spec.md`, `plan.md`, `tasks.md`) como fuente de verdad.
2. Elegir el **modo adecuado** (`startup` o `enterprise`) según el nivel de criticidad y los requisitos del cliente.
3. Orquestar skills de Antigravity Kit (frontend, backend, BD, testing, seguridad, DevOps) para producir código, tests y pipelines de calidad senior.
4. **Nunca comprometer la seguridad**, sin importar el modo.

Este skill es un complemento del skill SDD que genera especificaciones y planes; aquí nos enfocamos en **pasar de la planificación a la acción**.

---

## Requisitos previos

Antes de usar este skill, se asume que:

- Existe un directorio `.specify/` en el proyecto con al menos:
  - `.specify/memory/constitution.md`
  - `.specify/specs/<NNN>-<feature>/spec.md`
  - `.specify/specs/<NNN>-<feature>/plan.md`
  - `.specify/specs/<NNN>-<feature>/tasks.md`
- Hay un skill SDD instalado que ayuda a crear/actualizar estos artefactos.
- Antigravity Kit está disponible con sus skills de:
  - Arquitectura y planificación, frontend, backend, bases de datos, testing, seguridad, DevOps y performance.

---

## Modos de operación

Este skill soporta dos modos principales, configurados en `/config/modes.yaml`:

### `startup`
- **Objetivo:** velocidad, time-to-market, simplicidad de arquitectura.
- **Uso:** MVPs, prototipos, productos de startup.
- **Arquitectura preferida:** monolito o modular monolith.
- **Testing:** alta cobertura en flujos críticos (>= 70%), menos capas ceremoniales.
- **Infra:** PaaS simple / despliegue rápido.

### `enterprise`
- **Objetivo:** robustez, compliance, escalabilidad, observabilidad.
- **Uso:** sistemas core, regulados, multi-equipo.
- **Arquitectura preferida:** modular monolith o servicios bien definidos.
- **Testing:** pirámide completa (unit, integration, E2E) con gates estrictos (>= 85%).
- **Infra:** despliegues multi-entorno, observabilidad, seguridad reforzada.

> **En ambos modos la seguridad es obligatoria y no negociable.** El agente debe aplicar siempre el baseline de `/config/security_baseline.md`.

---

## Flujo de trabajo de alto nivel

### 1. Descubrir artefactos SDD
- Buscar `.specify/memory/constitution.md`.
- Detectar `spec.md`, `plan.md`, `tasks.md` relevantes para la feature.
- Si faltan, pedir al usuario que ejecute el skill SDD para crearlos.

### 2. Elegir modo (`startup` vs `enterprise`)
- Leer `constitution.md` buscando palabras clave:
  - `MVP`, `prototipo`, `experimento` → `startup`.
  - `compliance`, `regulado`, `SLA`, `PCI`, `HIPAA`, `finanzas`, `enterprise` → `enterprise`.
- Permitir al usuario forzar el modo explicitamente.
- Registrar el modo activo.

### 3. Validar artefactos SDD (Quality Gate 1)
- `spec.md` tiene user stories claras con criterios GIVEN–WHEN–THEN.
- `plan.md` cubre arquitectura, modelo de datos, contratos de API.
- `tasks.md` cubre todos los criterios de aceptación.
- **Si algo falta, NO avanzar a implementación.** Pedir al usuario que complete con el skill SDD.

### 4. Construir estrategia de ejecución

Seleccionar skills de Antigravity Kit en función del modo:

**Modo startup:**
- Priorizar skills de rapidez y simplicidad (React/TS, Node, monolitos, despliegue simple).
- SIEMPRE incluir skills de seguridad, testing y clean code.

**Modo enterprise:**
- Incluir skills de arquitectura avanzada, seguridad profunda, observabilidad, performance y testing exhaustivo.

### 5. Implementación guiada por Tasks
- Seguir el orden de `.specify/specs/<feature>/tasks.md`.
- Para cada tarea:
  - Entender el objetivo y la ruta de archivo.
  - Elegir los skills apropiados (frontend, backend, BD, tests, DevOps).
  - Escribir o modificar código siguiendo estándares del modo y la constitución.
  - Si la tarea involucra seguridad (auth, autorización, datos sensibles), activar explicitamente skills de seguridad (OWASP, hardening de headers, validación de inputs).
  - Asegurarse de que los tests se actualicen y ejecuten con éxito.

### 6. Quality Gate Final
- Ejecutar `/scripts/security_checklist.sh` para asegurar que el trabajo respeta `/config/security_baseline.md`.
- Ejecutar `/scripts/quality_gate.sh` para verificar cobertura mínima según modo.
- Solo considerar el trabajo **"done"** si pasa ambos gates.

---

## Skills de Antigravity Kit recomendados por fase

| Fase | Skills Antigravity Kit |
|---|---|
| Arquitectura | `architecture`, `app-builder`, `plan-writing` |
| Frontend | `react-best-practices`, `frontend-design`, `web-design-guidelines` |
| Backend | `api-patterns`, `nodejs-best-practices` |
| Base de datos | `database-design` |
| Testing | `tdd-workflow`, `testing-patterns`, `webapp-testing`, `code-review-checklist` |
| Seguridad | `vulnerability-scanner`, `red-team-tactics` |
| Calidad | `lint-and-validate`, `clean-code`, `systematic-debugging` |
| DevOps | `deployment-procedures`, `server-management` |
| Observabilidad | `performance-profiling` |

---

## Comandos sugeridos para el usuario

```
"Usa el Fullstack SDD Executor en modo startup para implementar la feature 001-todo."
"En modo enterprise, implementa el servicio de pagos siguiendo .specify/specs/010-payments/*."
"Revisa el código actual en modo enterprise y dime qué rompe la security baseline."
```

---

## Notas de seguridad (obligatorio)

Este skill **nunca** debe:
- Saltarse la validación de `/config/security_baseline.md`.
- Desplegar o sugerir despliegues de código que no hayan pasado tests y validación de seguridad.

Si el usuario intenta forzar "omitir seguridad" o "acelerar saltando tests", el agente debe:
1. Explicar por qué no es aceptable.
2. Ofrecer alternativas (implementar una versión más pequeña pero segura, diferir optimizaciones no relacionadas con seguridad).

# Workflow: Enterprise Full Cycle (SDD → Código)

## Propósito

Ejecutar el ciclo completo de desarrollo para sistemas críticos, regulados o de alto impacto donde la robustez, la seguridad y la observabilidad son la prioridad principal.

---

## Pasos

### Paso 1: Leer artefactos SDD
- Localizar `.specify/memory/constitution.md`.
- Localizar `.specify/specs/<NNN>-<feature>/spec.md`, `plan.md`, `tasks.md`.
- Validar especialmente:
  - Requisitos no funcionales claros (SLA, seguridad, rendimiento, compliance).
  - Si no existen o están incompletos, detener y usar el skill SDD primero.

### Paso 2: Confirmar modo `enterprise`
- Forzar modo `enterprise` en el contexto.
- Registrar `config/modes.yaml → enterprise`.
- Informar al usuario: "Modo enterprise activo. Cobertura mínima: 85%. Seguridad: obligatoria + checks extra."

### Paso 3: Validar spec/plan/tasks (Quality Gate 1 — más estricto)

**No continuar si:**
- [ ] Faltan requisitos de seguridad o compliance en `spec.md`.
- [ ] `plan.md` no cubre logging estructurado, métricas y estrategia de despliegue.
- [ ] `tasks.md` no incluye tareas de testing de seguridad y hardening.
- [ ] Los requisitos no funcionales (SLA, rendimiento) no están cuantificados.

### Paso 4: Seleccionar skills de Antigravity Kit

| Capa | Skills a usar |
|---|---|
| Arquitectura | `architecture` (enterprise), `app-builder`, `plan-writing` |
| Frontend | `react-best-practices`, `frontend-design`, `web-design-guidelines` |
| Backend | `api-patterns`, `nodejs-best-practices` |
| Base de datos | `database-design` |
| Testing | `tdd-workflow`, `testing-patterns`, `webapp-testing`, `code-review-checklist` |
| Calidad | `lint-and-validate`, `clean-code`, `systematic-debugging` |
| Seguridad (obligatorio) | `vulnerability-scanner`, `red-team-tactics` |
| DevOps | `deployment-procedures`, `server-management` |
| Observabilidad | `performance-profiling` |

### Paso 5: Implementación guiada por tasks con foco enterprise

Para cada tarea de `tasks.md`:
1. Mantener separación clara de capas (presentación / lógica de negocio / persistencia).
2. Introducir logging estructurado (JSON logs con contexto: userId, requestId, etc.).
3. Añadir métricas en endpoints clave (tiempo de respuesta, errores, throughput).
4. Introducir feature flags donde aplique (para lanzamientos graduales).
5. Si la tarea involucra auth, datos sensibles, pagos o compliance:
   - Activar skills `vulnerability-scanner` y `red-team-tactics`.
   - Verificar contra `config/security_baseline.md`.
   - Documentar la decisión en `IMPLEMENTATION_NOTES.md`.

### Paso 6: Aplicar Security Baseline + Checks Extra Enterprise

**Baseline obligatorio** (igual que startup):
- [ ] Sin secrets hardcodeados.
- [ ] Inputs validados en backend.
- [ ] Endpoints críticos con autenticación.
- [ ] Passwords hasheadas.
- [ ] HTTPS + headers de seguridad.
- [ ] CORS restringido.

**Extra enterprise:**
- [ ] Auditoría de dependencias (`npm audit --audit-level=moderate`).
- [ ] Políticas de rotación de keys y tokens documentadas.
- [ ] Revisión estática (SAST) cuando aplique.
- [ ] Revisión de dependencias de terceros.
- [ ] Escaneo de vulnerabilidades si hay integración con herramienta disponible.

Ejecutar: `bash scripts/security_checklist.sh enterprise`

### Paso 7: Quality Gate Final (enterprise)

Ejecutar: `bash scripts/quality_gate.sh enterprise`

Debe verificar:
- [ ] Cobertura de tests >= 85%.
- [ ] Tests unitarios, de integración y E2E verdes.
- [ ] Tests de carga básicos (si aplica para el componente).
- [ ] Requisitos de rendimiento de `spec.md` validados (al menos en entorno local/staging).
- [ ] Logging estructurado funcional.
- [ ] Métricas operativas disponibles.
- [ ] Sin errores de TypeScript.
- [ ] Sin warnings de ESLint.

**Si falla:** no marcar como DONE bajo ninguna circunstancia.

### Paso 8: Documentar

Actualizar o crear `IMPLEMENTATION_NOTES.md` con:
- Decisiones arquitectónicas clave y su justificación.
- Skills de Antigravity Kit usados en cada fase.
- Riesgos identificados y cómo se mitigaron.
- Compromisos de rendimiento validados.
- Recomendaciones para la próxima iteración.
- Deudas técnicas aceptadas (NUNCA de seguridad).

---

## Principio de oro enterprise

> Un sistema enterprise no se termina cuando "funciona".
> Se termina cuando funciona, es seguro, es observable, tiene tests y está documentado.

**La seguridad nunca es deuda técnica aceptable.**

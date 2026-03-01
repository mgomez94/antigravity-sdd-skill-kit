# Workflow: Startup Full Cycle (SDD → Código)

## Propósito

Ejecutar el ciclo completo de desarrollo para features de MVP/startup donde se optimiza la velocidad al mercado, **sin sacrificar la seguridad**.

---

## Pasos

### Paso 1: Leer artefactos SDD
- Localizar `.specify/memory/constitution.md`.
- Localizar `.specify/specs/<NNN>-<feature>/spec.md`, `plan.md`, `tasks.md`.
- Si no existen, detener y ejecutar el skill SDD primero.

### Paso 2: Confirmar modo `startup`
- Forzar modo `startup` en el contexto.
- Registrar que se usará `config/modes.yaml → startup`.
- Informar al usuario: "Modo startup activo. Cobertura mínima: 70%. Seguridad: obligatoria."

### Paso 3: Validar spec/plan/tasks (Quality Gate 1)

Verificar que:
- [ ] `spec.md` tiene user stories con criterios GIVEN–WHEN–THEN.
- [ ] `spec.md` incluye restricciones de seguridad relevantes.
- [ ] `plan.md` define arquitectura, stack y decisiones técnicas.
- [ ] `tasks.md` cubre todos los criterios de aceptación de `spec.md`.

**Si no pasa:** detener y pedir ajuste con el skill SDD.

### Paso 4: Seleccionar skills de Antigravity Kit

| Capa | Skills a usar |
|---|---|
| Arquitectura | `architecture`, `app-builder`, `plan-writing` |
| Frontend | `react-best-practices`, `frontend-design` |
| Backend | `api-patterns`, `nodejs-best-practices` |
| Base de datos | `database-design` |
| Testing | `tdd-workflow`, `testing-patterns`, `clean-code` |
| Seguridad (obligatorio) | `vulnerability-scanner` |
| Calidad | `lint-and-validate` |
| DevOps | `deployment-procedures` |

### Paso 5: Implementación guiada por tasks

Para cada tarea de `tasks.md`:
1. Identificar tipo (frontend, backend, BD, infra).
2. Invocar los skills adecuados de Antigravity Kit.
3. Escribir código + tests.
4. Ejecutar tests localmente.
5. Si la tarea involucra auth, datos sensibles o endpoints externos:
   - Activar skill de seguridad.
   - Verificar contra `config/security_baseline.md`.

### Paso 6: Aplicar Security Baseline (obligatorio)

Revisar cambios contra `config/security_baseline.md`:
- [ ] Sin secrets hardcodeados.
- [ ] Inputs validados en backend.
- [ ] Endpoints críticos con autenticación.
- [ ] Passwords hasheadas.
- [ ] HTTPS configurado.
- [ ] Headers de seguridad en su lugar (helmet.js).
- [ ] CORS restringido.

Ejecutar: `bash scripts/security_checklist.sh`

### Paso 7: Quality Gate Final (startup)

Ejecutar: `bash scripts/quality_gate.sh startup`

Debe verificar:
- [ ] Cobertura de tests >= 70%.
- [ ] Tests de flujos críticos (auth, operaciones principales) verdes.
- [ ] Sin errores de TypeScript.
- [ ] Sin warnings de ESLint.

**Si falla:** iterar hasta cumplir. No marcar como DONE.

### Paso 8: Documentar

Actualizar o crear `IMPLEMENTATION_NOTES.md` con:
- Stack y skills de Antigravity Kit usados.
- Decisiones de arquitectura tomadas.
- Deudas técnicas aceptadas (solo no-seguridad).
- Pendientes identificados.

---

## Diferencia clave con Enterprise

| Aspecto | Startup | Enterprise |
|---|---|---|
| Cobertura mínima | 70% | 85% |
| Tests de carga | No requeridos | Requeridos |
| Observabilidad | Mínima (logs básicos) | Completa (métricas, trazas) |
| Arquitectura | Monolito simple | Modular estructurado |
| Auditoría deps | Recomendada | Obligatoria |
| **Seguridad** | **Obligatoria** | **Obligatoria** |

---

## Nota importante

El modo startup NO significa:
- Saltarse tests.
- Ignorar validación de inputs.
- Hardcodear secrets.
- Omitir autenticación.

Significa: arquitectura más simple, menos ceremonias, pero el mismo nivel de seguridad.

# 05. Quality Gates - Puntos de Control SDD

## ¿Qué son los Quality Gates?

Los Quality Gates son puntos de control obligatorios entre cada fase del proceso SDD. **No se puede avanzar a la siguiente fase sin pasar el gate anterior.** Esto garantiza que no se construya código sobre bases frágiles o especificaciones incompletas.

---

## Gate 1: Constitution → Specification

### Checklist
- [ ] `constitution.md` existe en `.specify/memory/`
- [ ] Stack tecnológico definido
- [ ] Principios arquitectónicos documentados
- [ ] Estándares de código especificados
- [ ] Restricciones de seguridad identificadas
- [ ] Revisada y aprobada por el líder técnico

### Criterio de Paso
Todos los ítems marcados como completados.

---

## Gate 2: Specification → Plan

### Checklist
- [ ] `spec.md` tiene estado `Approved`
- [ ] Al menos 1 User Story con criterios GIVEN-WHEN-THEN
- [ ] Todos los criterios de aceptación son verificables (testables)
- [ ] Requisitos No Funcionales definidos:
  - [ ] Rendimiento (tiempo de respuesta)
  - [ ] Seguridad (autenticación/autorización)
  - [ ] Escalabilidad (carga esperada)
- [ ] Casos borde identificados (mínimo 3)
- [ ] Dependencias externas listadas
- [ ] Preguntas abiertas: todas resueltas
- [ ] Revisada por al menos 1 persona adicional

### Anti-patrones que deben estar AUSENTES
- Requisitos vagos como "el sistema debe ser rápido"
- Criterios de aceptación que no se pueden automatizar
- Ausencia de casos de error
- Dependencias no identificadas

### Criterio de Paso
Todos los checks completados + sin anti-patrones.

---

## Gate 3: Plan → Tasks

### Checklist
- [ ] `plan.md` tiene estado `Approved`
- [ ] Cada RF del spec tiene al menos un componente en el plan
- [ ] Modelo de datos consistente con la constitución
- [ ] Contratos de API definidos para todos los endpoints
- [ ] Estructura de carpetas documentada
- [ ] Decisiones técnicas con razón documentada
- [ ] Riesgos técnicos identificados con plan de mitigación
- [ ] Estrategia de testing definida
- [ ] Estimación de tiempo realista
- [ ] Revisado por arquitecto o desarrollador senior

### Anti-patrones que deben estar AUSENTES
- Componentes sin responsabilidad clara
- Modelo de datos inconsistente con restricciones de la constitución
- "Haremos el diseño durante la implementación"
- Riesgos críticos sin mitigación

### Criterio de Paso
Todos los checks + aprobación del arquitecto.

---

## Gate 4: Tasks → Implementation

### Checklist
- [ ] Cada criterio de aceptación de spec.md tiene al menos una tarea asociada
- [ ] Dependencias entre tareas claras
- [ ] No hay "huecos" en el flujo (todas las fases cubiertas)
- [ ] Tareas de testing incluidas
- [ ] T-001 (setup/migración) marcada como BLOCKER
- [ ] Tiempo estimado por tarea entre 20-90 minutos
- [ ] Tarea de documentación final incluida

### Anti-patrones que deben estar AUSENTES
- Tareas de más de 2 horas (demasiado grande)
- Tareas de menos de 10 minutos (demasiado pequeña o trivial)
- Tareas sin criterio de "hecho" claro
- Testing como única tarea final (debe estar distribuido)

### Criterio de Paso
Todos los checks completados.

---

## Gate 5: Implementation → Done

### Checklist
- [ ] Todos los criterios GIVEN-WHEN-THEN de spec.md pasan
- [ ] Cobertura de tests >= 80% en código nuevo
- [ ] No hay errores en consola (nivel error/critical)
- [ ] Linting pasa sin errores
- [ ] Code review completado por al menos 1 persona
- [ ] `IMPLEMENTATION_NOTES.md` creado
- [ ] Desviaciones respecto a spec documentadas (si las hubo)
- [ ] PR aprobado
- [ ] Deploy en staging verificado
- [ ] Stakeholder ha validado la feature en staging

### Criterio de Paso
Todos los checks + aprobación del stakeholder en staging.

---

## Script de Verificación Rápida

Antes de cada gate, el agente de Antigravity debe ejecutar este checklist mental:

```
GATE CHECK:
1. ¿Existe el artefacto de la fase anterior? (constitution/spec/plan/tasks.md)
2. ¿Tiene estado Approved?
3. ¿El checklist del gate correspondiente está completo?
4. ¿Hay anti-patrones presentes?

Si alguna respuesta es NO -> DETENER y resolver antes de continuar.
```

---

## Manejo de Excepciones

En casos urgentes (hotfix, bugfix crítico), se puede hacer SDD simplificado:

| Situación | SDD Simplificado | Qué se omite |
|---|---|---|
| Hotfix en producción | spec + tasks mínimos | plan detallado |
| Bugfix simple | tasks mínimos | spec + plan |
| Feature pequeña (< 1h) | spec mínima + tasks | plan arquitectónico |

**IMPORTANTE**: Siempre documentar la decisión de omitir un gate en `IMPLEMENTATION_NOTES.md` con la razón.

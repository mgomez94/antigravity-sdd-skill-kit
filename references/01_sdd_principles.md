# 01. Principios Fundamentales del Specs Driven Development (SDD)

## ¿Qué es SDD?

Specs Driven Development (SDD) es una metodología de desarrollo de software donde **las especificaciones escritas por humanos preceden y guian cada línea de código**. En lugar de "vibe coding" (escribir código directamente en el editor o dictarle instrucciones vagas a un agente de IA), SDD exige que primero exista un documento que defina:

- Qué debe hacer el sistema (spec.md)
- Cómo debe construirse (plan.md)
- En qué orden (tasks.md)

## Los 5 Principios Clave

### 1. Human Reviewability (Revisabilidad Humana)
Toda especificación debe poder ser leída, entendida y aprobada por un humano en menos de 30 minutos. Si es más larga o compleja, se divide.

**Regla práctica**: Si no puedes revisar la spec en una reunión de 30 min, está mal dimensionada.

### 2. Minimal Specs (Especificaciones Mínimas)
Las specs deben ser lo suficientemente detalladas para guiar la implementación, pero no tan exhaustivas que se conviertan en documentación muerta.

**Regla práctica**: 3-5 páginas por feature. Nunca más de 10.

### 3. Meaningful Decomposition (Descomposición Significativa)
Cada feature debe descomponerse en unidades que tengan sentido desde el punto de vista del negocio Y de la implementación.

**Regla práctica**: Una tarea = 30-60 minutos de trabajo real.

### 4. Traceability (Trazabilidad)
Cada tarea en `tasks.md` debe poder rastrearse hasta un requisito en `spec.md`. Si una tarea no corresponde a ningún requisito, sobra.

**Regla práctica**: Usa IDs de requisitos (ej. REQ-001) y reférencialos en las tareas.

### 5. Spec-Code Alignment (Alineación Spec-Código)
El código implementado debe reflejar lo que dice la spec. Si hay desviaciones, se documentan en `IMPLEMENTATION_NOTES.md`.

**Regla práctica**: Antes de cerrar una feature, verifica que los criterios de aceptación pasen los tests.

---

## Las 6 Fases del Proceso SDD

### Fase 0: Constitution
**Objetivo**: Establecer los principios, restricciones y estándares del proyecto.

**Artefacto**: `.specify/memory/constitution.md`

**Contenido**:
- Tipo de proyecto y dominio
- Stack tecnológico
- Estándares de código y testing
- Restricciones de seguridad, rendimiento, escalabilidad
- Principios arquitectónicos

**Cuándo actualizarla**: Solo cuando hay cambios fundamentales al proyecto.

### Fase 1: Specify
**Objetivo**: Escribir el "qué" antes del "cómo".

**Artefacto**: `.specify/specs/NNN-nombre/spec.md`

**Contenido**:
- User stories en formato GIVEN-WHEN-THEN
- Requisitos funcionales (RF)
- Requisitos no funcionales (RNF)
- Casos borde (edge cases)
- Dependencias externas

### Fase 2: Clarify
**Objetivo**: Resolver ambigüedades antes de planificar.

**Artefacto**: Actualizaciones en `spec.md` + `Estado: Approved`

**Actividades**:
- Generar lista de preguntas abiertas
- Obtener respuestas del stakeholder/PO
- Integrar respuestas en la spec
- Obtener aprobación formal

### Fase 3: Plan
**Objetivo**: Diseñar la arquitectura técnica.

**Artefacto**: `.specify/specs/NNN-nombre/plan.md`

**Contenido**:
- Componentes y su responsabilidad
- Modelo de datos (tablas, campos, relaciones)
- Contratos de API (endpoints, request/response)
- Decisiones técnicas y trade-offs
- Plan de migración (si aplica)

### Fase 4: Tasks
**Objetivo**: Descomponer el plan en trabajo ejecutable.

**Artefacto**: `.specify/specs/NNN-nombre/tasks.md`

**Contenido**:
- Lista numerada de tareas
- Dependencias entre tareas
- Tareas paralelas marcadas con [P]
- Tests incluidos por tarea
- Rutas de archivos a modificar

### Fase 5: Implement
**Objetivo**: Ejecutar las tareas siguiendo spec y plan.

**Artefactos**: Código + tests + `IMPLEMENTATION_NOTES.md`

---

## Estructura de Carpetas `.specify/`

```
.specify/
  memory/
    constitution.md          # Principios del proyecto
  specs/
    001-nombre-feature/
      spec.md               # Qué hace
      plan.md               # Cómo se construye
      tasks.md              # En qué orden
      IMPLEMENTATION_NOTES.md  # Post-implementación
    002-otra-feature/
      ...
  templates/                # Opcional: copias de templates
```

---

## Comparación: Vibe Coding vs SDD

| Aspecto | Vibe Coding | SDD |
|---|---|---|
| Inicio | Escribir código inmediatamente | Escribir spec primero |
| Velocidad inicial | Muy rápida | Más lenta (15-30 min extra) |
| Calidad | Variable | Alta y predecible |
| Bugs en producción | Frecuentes | Reducidos 60-80% |
| Onboarding | Difícil | Fácil (spec como documentación) |
| Escalabilidad | Problemática | Estructurada |
| Con agentes de IA | Resultados impredecibles | Resultados consistentes |

---

## Cuándo Usar SDD

**Siempre usar SDD cuando**:
- La feature afecta a múltiples componentes
- El tiempo estimado es mayor a 2 horas
- Trabaja más de una persona
- Se usa un agente de IA para la implementación
- Hay requisitos de seguridad o compliance

**SDD simplificado (solo spec + tasks) cuando**:
- Feature pequeña, un solo componente
- Tiempo estimado menor a 1 hora
- Desarrollador único con pleno contexto

**No usar SDD cuando**:
- Es un bugfix trivial
- Es un cambio de estilos/textos
- Es un experimento desechable (prueba de concepto)

---

## Métricas de Éxito SDD

- **Tasa de bugs en producción**: Debe bajar 50%+ en 3 meses
- **Tiempo de onboarding**: Nuevo developer competente en 5 horas (leyendo specs)
- **Rework**: Menos del 10% de tareas requieren replanificación
- **Predictibilidad de entrega**: 80%+ de features entregadas en el tiempo estimado
- **Cobertura de tests**: 70%+ en features SDD vs 30% en vibe coding

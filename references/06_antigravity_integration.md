# 06. Integración con Antigravity

## Estructura del Skill en Antigravity

Este skill sigue la estructura estándar de Antigravity Skills:

```
antigravity-sdd-skill-kit/
  SKILL.md           <- Entrypoint: le dice al agente qué hace este skill
  references/        <- Documentación que el agente puede leer
  examples/          <- Ejemplos reales para que el agente aprenda patrones
  scripts/           <- Scripts ejecutables para automatizar tareas
```

## Cómo Instalar el Skill en tu Antigravity Local

### Opción 1: Clonar directamente en la carpeta de skills

```bash
# Ve a la carpeta donde tienes tus skills de Antigravity
cd /ruta/a/tu/antigravity/skills

# Clona el repositorio
git clone https://github.com/mgomez94/antigravity-sdd-skill-kit.git

# Listo - Antigravity lo detecta automáticamente en el siguiente inicio
```

### Opción 2: Si usas Antigravity Kit

```bash
# Dentro de tu workspace de Antigravity Kit
cd skills/
git clone https://github.com/mgomez94/antigravity-sdd-skill-kit.git
```

### Opción 3: Submódulo Git (para mantener sincronizado)

```bash
git submodule add https://github.com/mgomez94/antigravity-sdd-skill-kit.git skills/antigravity-sdd-skill-kit
git submodule update --init
```

---

## Uso del Skill en Antigravity

### Configurar el Agente Senior SDD

En tu `AGENTS.md` o `Antigravity.md`, agrega:

```markdown
## Agente: Senior SDD Architect

### Descripción
Agente especializado en Specs Driven Development. Usa este agente para:
- Diseñar nuevas features con spec + plan + tasks antes de escribir código
- Revisar especificaciones existentes
- Descomponer features grandes en tareas ejecutables

### Skills
- antigravity-sdd-skill-kit

### Instrucciones
Antes de escribir cualquier línea de código para una feature nueva o cambio significativo:
1. Lee el SKILL.md del skill antigravity-sdd-skill-kit
2. Sigue el flujo: Constitution -> Specify -> Clarify -> Plan -> Tasks -> Implement
3. Crea los artefactos en `.specify/`
4. Verifica los Quality Gates antes de avanzar entre fases
5. Usa los templates de /references para cada artefacto
```

---

## Flujo de Trabajo con Antigravity

### 1. Iniciar un proyecto nuevo con SDD

```
Tu prompt a Antigravity:
"Usa el skill SDD para inicializar este proyecto. Ejecuta el script init_sdd_project.sh y crea la constitution.md base con nuestro stack: React + TypeScript en frontend, Node.js + Express en backend, PostgreSQL como BD."
```

Antigravity ejecutará:
1. `scripts/init_sdd_project.sh` para crear estructura `.specify/`
2. Crear `constitution.md` con tu stack
3. Pedirte confirmación

### 2. Especificar una nueva feature

```
Tu prompt a Antigravity:
"Usa el skill SDD para especificar la feature de login con Google OAuth. Sigue el flujo completo: spec -> plan -> tasks. No empieces a codear hasta que yo apruebe el plan."
```

Antigravity ejecutará:
1. Crear `.specify/specs/001-google-oauth/spec.md` usando template
2. Mostrarte la spec y esperar tu feedback
3. Crear `plan.md` después de tu aprobación
4. Crear `tasks.md` después de aprobar el plan
5. Pedir tu OK para comenzar implementación

### 3. Agregar una feature rápida

```
Tu prompt a Antigravity:
"Crea una nueva feature SDD usando new_feature.sh con ID 002 y slug 'user-profile'. Solo necesito spec + tasks, sin plan detallado por ahora."
```

---

## Uso con AGENTS.md (Estilo Moderno)

Si usas el estilo moderno de Antigravity con `AGENTS.md`:

```markdown
# AGENTS.md

## Comportamiento General
Siempre que el usuario pida crear o extender una feature significativa,
USA el skill antigravity-sdd-skill-kit ANTES de escribir código.

## Flujo Obligatorio para Features
1. Verificar si existe .specify/memory/constitution.md
2. Si no existe: ejecutar scripts/init_sdd_project.sh
3. Crear spec usando references/02_spec_templates.md
4. Esperar aprobación del usuario
5. Crear plan usando references/03_plan_templates.md
6. Esperar aprobación del usuario
7. Crear tasks usando references/04_tasks_templates.md
8. Verificar quality gates (references/05_quality_gates.md)
9. Implementar tarea por tarea

## Excepciones (NO requieren SDD completo)
- Bugfixes triviales
- Cambios de estilos/textos
- Refactoring menor (< 1 hora)
```

---

## Comandos Útiles en Terminal de Antigravity

```bash
# Inicializar estructura SDD en proyecto actual
bash skills/antigravity-sdd-skill-kit/scripts/init_sdd_project.sh

# Crear nueva feature SDD
bash skills/antigravity-sdd-skill-kit/scripts/new_feature.sh 001 nombre-feature

# Validar spec actual
bash skills/antigravity-sdd-skill-kit/scripts/validate_spec.sh .specify/specs/001-nombre-feature/spec.md

# Validar plan actual
bash skills/antigravity-sdd-skill-kit/scripts/validate_plan.sh .specify/specs/001-nombre-feature/plan.md

# Correr ciclo SDD completo
bash skills/antigravity-sdd-skill-kit/scripts/run_full_sdd_cycle.sh 001 nombre-feature
```

---

## Integración con Antigravity.md

Si usas `Antigravity.md` como archivo de configuración:

```markdown
# Antigravity.md

## Skills Activos
- antigravity-sdd-skill-kit: Para desarrollo guiado por especificaciones

## Reglas de Desarrollo
- SIEMPRE usar SDD para features que tomen más de 2 horas
- Los artefactos SDD viven en .specify/
- Nunca hacer commit de código sin tests
- La spec debe estar Approved antes de planificar
- El plan debe estar Approved antes de tareas
```

---

## Actualización del Skill

Para obtener la última versión del skill:

```bash
cd skills/antigravity-sdd-skill-kit
git pull origin main
```

O si usas submódulo:

```bash
git submodule update --remote skills/antigravity-sdd-skill-kit
```

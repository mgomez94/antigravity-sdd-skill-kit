# 04. Templates de Tareas (tasks.md)

## Template Base: tasks.md

```markdown
# Tareas: [Nombre de la Feature]

**Spec ID**: [NNN]
**Plan aprobado**: Sí/No
**Fecha**: [YYYY-MM-DD]
**Asignado a**: [Nombre o equipo]
**Tiempo total estimado**: [N] horas

---

## Convenciones

- `[P]` = Tarea paralelizable (puede hacerse a la vez que otras)
- `[BLOCKER]` = Tarea que bloquea a otras, hacerla primero
- `[TEST]` = Tarea de testing
- `Dep: T-XXX` = Depende de la tarea con ese número
- `RF-XXX` = Cubre el requisito funcional con ese ID

---

## FASE 0: Setup y Migraciones [BLOCKER]

### T-001: Crear migración de base de datos
- **Tiempo**: 30 min
- **Archivo**: `migrations/[fecha]_[nombre].sql`
- **Acciones**:
  - [ ] Crear tabla(s) según plan.md sección 3
  - [ ] Agregar índices
  - [ ] Crear script de rollback
  - [ ] Probar en local
- **Test**: Verificar que la migración corre sin errores
- **Cubre**: RF-001

---

## FASE 1: Backend - Capa de Datos [P]

### T-002: Crear Repository
- **Tiempo**: 45 min
- **Archivo**: `src/repositories/[nombre].repository.ts`
- **Dep**: T-001
- **Acciones**:
  - [ ] Método `findById(id: string)`
  - [ ] Método `findAll(filters?: FilterDto)`
  - [ ] Método `create(data: CreateDto)`
  - [ ] Método `update(id: string, data: UpdateDto)`
  - [ ] Método `delete(id: string)`
- **Test**: `src/repositories/[nombre].repository.test.ts`
  - [ ] Test: findById existente
  - [ ] Test: findById no existente -> null
  - [ ] Test: create con datos válidos
  - [ ] Test: create con datos inválidos -> error
- **Cubre**: RF-001, RF-002

### T-003: Crear Validators/DTOs [P]
- **Tiempo**: 30 min
- **Archivo**: `src/validators/[nombre].validator.ts`
- **Acciones**:
  - [ ] `Create[Nombre]Dto` con validaciones
  - [ ] `Update[Nombre]Dto` con validaciones
  - [ ] `Filter[Nombre]Dto` con paginación
- **Test**: Tests unitarios de validación

---

## FASE 2: Backend - Capa de Negocio [P]

### T-004: Crear Service
- **Tiempo**: 60 min
- **Archivo**: `src/services/[nombre].service.ts`
- **Dep**: T-002, T-003
- **Acciones**:
  - [ ] Método `getById(id: string)` con manejo de not found
  - [ ] Método `getAll(filters: FilterDto)` con paginación
  - [ ] Método `create(data: CreateDto, userId: string)`
  - [ ] Método `update(id: string, data: UpdateDto, userId: string)`
  - [ ] Método `delete(id: string, userId: string)` con verificación de permisos
- **Test**: `src/services/[nombre].service.test.ts`
  - [ ] Test: getById - éxito
  - [ ] Test: getById - not found -> NotFoundException
  - [ ] Test: create - datos válidos
  - [ ] Test: delete - sin permiso -> ForbiddenException

---

## FASE 3: Backend - Capa de Presentación [P]

### T-005: Crear Controller y Routes
- **Tiempo**: 45 min
- **Archivos**:
  - `src/controllers/[nombre].controller.ts`
  - `src/routes/[nombre].routes.ts`
- **Dep**: T-004
- **Acciones**:
  - [ ] `GET /api/[recurso]` - listar con paginación
  - [ ] `GET /api/[recurso]/:id` - obtener uno
  - [ ] `POST /api/[recurso]` - crear
  - [ ] `PUT /api/[recurso]/:id` - actualizar
  - [ ] `DELETE /api/[recurso]/:id` - eliminar
  - [ ] Middleware de autenticación donde aplique
- **Test**: Integration tests
  - [ ] `POST /api/[recurso]` - 201 con datos válidos
  - [ ] `POST /api/[recurso]` - 400 con datos inválidos
  - [ ] `POST /api/[recurso]` - 401 sin autenticación
  - [ ] `GET /api/[recurso]/:id` - 404 si no existe

---

## FASE 4: Frontend [P]

### T-006: Crear tipos TypeScript e interfaces
- **Tiempo**: 20 min
- **Archivo**: `src/components/[Nombre]/types.ts`
- **Dep**: T-005
- **Acciones**:
  - [ ] Interface `[Nombre]`
  - [ ] Interface `Create[Nombre]Request`
  - [ ] Interface `[Nombre]ListResponse`

### T-007: Crear Service (API calls)
- **Tiempo**: 30 min
- **Archivo**: `src/services/[nombre].service.ts`
- **Dep**: T-006
- **Acciones**:
  - [ ] `get[Nombre]s(filters?: FilterDto)`
  - [ ] `get[Nombre]ById(id: string)`
  - [ ] `create[Nombre](data: CreateDto)`
  - [ ] `update[Nombre](id: string, data: UpdateDto)`
  - [ ] `delete[Nombre](id: string)`

### T-008: Crear Custom Hook [P]
- **Tiempo**: 45 min
- **Archivo**: `src/components/[Nombre]/hooks/use[Nombre].ts`
- **Dep**: T-007
- **Acciones**:
  - [ ] `use[Nombre]s()` - listar con React Query
  - [ ] `use[Nombre]Mutations()` - crear/actualizar/eliminar
  - [ ] Manejo de estados loading/error/success

### T-009: Crear Componente Principal
- **Tiempo**: 60 min
- **Archivo**: `src/components/[Nombre]/[Nombre].tsx`
- **Dep**: T-008
- **Acciones**:
  - [ ] UI de listado
  - [ ] Formulario de creación/edición
  - [ ] Confirmación de eliminación
  - [ ] Estados de carga y error
- **Test**: `[Nombre].test.tsx`
  - [ ] Renderiza lista correctamente
  - [ ] Muestra loading state
  - [ ] Muestra error state

---

## FASE 5: Integración y QA

### T-010: Integración End-to-End [TEST]
- **Tiempo**: 60 min
- **Dep**: T-005, T-009
- **Acciones**:
  - [ ] Probar flujo completo en local
  - [ ] Verificar todos los criterios GIVEN-WHEN-THEN de spec.md
  - [ ] Probar casos borde de spec.md sección 7
  - [ ] Probar en diferentes navegadores/dispositivos si aplica

### T-011: Documentación y Notas de Implementación
- **Tiempo**: 20 min
- **Archivo**: `IMPLEMENTATION_NOTES.md`
- **Acciones**:
  - [ ] Qué se implementó
  - [ ] Desviaciones respecto a spec/plan (si las hubo)
  - [ ] Pendientes para futuras iteraciones
  - [ ] Lecciones aprendidas

---

## Checklist Final antes de Marcar como Completado

- [ ] Todos los criterios de aceptación de spec.md pasan
- [ ] Cobertura de tests >= 80%
- [ ] No hay errores en consola ni warnings críticos
- [ ] Code review completado
- [ ] IMPLEMENTATION_NOTES.md creado
- [ ] PR aprobado y mergeado
```

---

## Ejemplo: Tasks para Sistema de Comentarios

```markdown
## T-001: Crear migración tabla comments [BLOCKER]
- **Tiempo**: 20 min
- **Archivo**: `migrations/20260301_create_comments.sql`
- **Acciones**:
  - [ ] CREATE TABLE comments (id, post_id, user_id, content, created_at)
  - [ ] CREATE INDEX idx_comments_post_id
  - [ ] Script de rollback DROP TABLE comments
- **Cubre**: RF-001

## T-002: Crear CommentsRepository [P]
- **Tiempo**: 30 min
- **Dep**: T-001
- **Acciones**:
  - [ ] findByPostId(postId): Comment[]
  - [ ] create(data): Comment
  - [ ] delete(id, userId): void
- **Test**: 3 tests unitarios
```

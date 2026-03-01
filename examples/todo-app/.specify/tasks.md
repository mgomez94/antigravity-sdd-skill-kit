# TASKS — Todo App (Ejemplo SDD)

## Sprint 1: Setup y Autenticación Backend

### TASK-001: Inicializar proyecto backend
- **Estado:** TODO
- **Estimación:** 2h
- **Descripción:** Crear proyecto Node.js + TypeScript con Express
- **Checklist:**
  - [ ] `npm init` y configurar tsconfig.json
  - [ ] Instalar dependencias: express, typescript, ts-node, nodemon
  - [ ] Configurar estructura de carpetas
  - [ ] Setup ESLint + Prettier
  - [ ] Crear .env.example

### TASK-002: Configurar base de datos PostgreSQL
- **Estado:** TODO
- **Estimación:** 2h
- **Descripción:** Conectar Prisma con PostgreSQL y crear esquema inicial
- **Checklist:**
  - [ ] Instalar Prisma
  - [ ] Configurar prisma/schema.prisma
  - [ ] Crear modelos User y Todo
  - [ ] Ejecutar migración inicial
  - [ ] Seed de datos de prueba

### TASK-003: Implementar autenticación
- **Estado:** TODO
- **Estimación:** 4h
- **Descripción:** Registro, login y middleware JWT
- **Checklist:**
  - [ ] Instalar jsonwebtoken, bcrypt
  - [ ] AuthService.register() con hash de password
  - [ ] AuthService.login() con validación
  - [ ] Generar JWT firmado
  - [ ] authMiddleware para rutas protegidas
  - [ ] Rutas POST /auth/register y POST /auth/login
  - [ ] Tests unitarios para AuthService

## Sprint 2: CRUD Todos y Frontend

### TASK-004: CRUD de tareas backend
- **Estado:** TODO
- **Estimación:** 3h
- **Descripción:** API completa de tareas con autorización
- **Checklist:**
  - [ ] TodoService.create(userId, data)
  - [ ] TodoService.findAll(userId, filters)
  - [ ] TodoService.update(id, userId, data)
  - [ ] TodoService.delete(id, userId)
  - [ ] TodoController con manejo de errores
  - [ ] Rutas GET/POST/PUT/DELETE /todos
  - [ ] Validaciones con express-validator
  - [ ] Tests unitarios TodoService

### TASK-005: Inicializar proyecto frontend
- **Estado:** TODO
- **Estimación:** 2h
- **Descripción:** React + TypeScript con Vite
- **Checklist:**
  - [ ] `npm create vite@latest` con React + TS
  - [ ] Instalar Redux Toolkit, React Router, Axios
  - [ ] Instalar TailwindCSS
  - [ ] Configurar store Redux
  - [ ] Configurar axios con interceptores

### TASK-006: Componentes de autenticación
- **Estado:** TODO
- **Estimación:** 4h
- **Descripción:** Login y registro en frontend
- **Checklist:**
  - [ ] LoginForm.tsx con validación
  - [ ] RegisterForm.tsx con validación
  - [ ] Hook useAuth con Redux
  - [ ] Persistencia de token en localStorage
  - [ ] Rutas protegidas PrivateRoute
  - [ ] Redirección post-login

### TASK-007: Componentes de tareas
- **Estado:** TODO
- **Estimación:** 5h
- **Descripción:** CRUD completo de tareas en frontend
- **Checklist:**
  - [ ] TodoList.tsx con listado
  - [ ] TodoItem.tsx con acciones inline
  - [ ] TodoForm.tsx para crear/editar
  - [ ] TodoFilters.tsx (todas/activas/completadas)
  - [ ] Búsqueda por texto en tiempo real
  - [ ] Hook useTodos con Redux
  - [ ] Estados de carga y error
  - [ ] Optimistic updates al completar

## Sprint 3: Tests y Deploy

### TASK-008: Tests backend
- **Estado:** TODO
- **Estimación:** 3h
- **Descripción:** Cobertura >= 80% en servicios
- **Checklist:**
  - [ ] Tests AuthService (register, login, errores)
  - [ ] Tests TodoService (CRUD, autorización)
  - [ ] Tests de integración rutas principales
  - [ ] Reporte de cobertura

### TASK-009: Tests frontend
- **Estado:** TODO
- **Estimación:** 3h
- **Descripción:** Tests con Vitest + Testing Library
- **Checklist:**
  - [ ] Tests LoginForm (renderizado, submit, errores)
  - [ ] Tests TodoList (listado, filtros)
  - [ ] Tests TodoItem (completar, eliminar)
  - [ ] Mock de API calls

### TASK-010: Documentación y README
- **Estado:** TODO
- **Estimación:** 1h
- **Descripción:** Documentar el proyecto
- **Checklist:**
  - [ ] README con instrucciones de setup
  - [ ] Variables de entorno documentadas
  - [ ] Endpoints API documentados
  - [ ] Ejemplos de uso

## Definición de Hecho (DoD)
- [ ] Código revisado (al menos 1 revisor)
- [ ] Tests pasando con cobertura >= 80%
- [ ] Sin errores de TypeScript
- [ ] Sin warnings de ESLint
- [ ] Funcionalidad probada manualmente
- [ ] Documentación actualizada

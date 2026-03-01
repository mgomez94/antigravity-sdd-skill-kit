# PLAN — Todo App (Ejemplo SDD)

## Resumen de Arquitectura

### Frontend (React + TypeScript)
```
src/
  components/
    Auth/
      LoginForm.tsx
      RegisterForm.tsx
    Todo/
      TodoList.tsx
      TodoItem.tsx
      TodoForm.tsx
      TodoFilters.tsx
  hooks/
    useAuth.ts
    useTodos.ts
  services/
    api.ts
    auth.service.ts
    todo.service.ts
  store/
    auth.slice.ts
    todo.slice.ts
  types/
    auth.types.ts
    todo.types.ts
  App.tsx
  main.tsx
```

### Backend (Node.js + Express + TypeScript)
```
src/
  controllers/
    auth.controller.ts
    todo.controller.ts
  middleware/
    auth.middleware.ts
    validate.middleware.ts
    rateLimit.middleware.ts
  models/
    user.model.ts
    todo.model.ts
  routes/
    auth.routes.ts
    todo.routes.ts
  services/
    auth.service.ts
    todo.service.ts
  config/
    database.ts
    env.ts
  app.ts
  server.ts
```

### Base de Datos (PostgreSQL)
```sql
-- Tabla users
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Tabla todos
CREATE TABLE todos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  title VARCHAR(500) NOT NULL,
  description TEXT,
  completed BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

## Fases de Implementación

### Fase 1: Setup Inicial (Día 1)
- Inicializar proyectos frontend y backend con TypeScript
- Configurar PostgreSQL y migraciones
- Configurar variables de entorno
- Setup de ESLint, Prettier, Husky

### Fase 2: Autenticación Backend (Día 2)
- Modelos User
- Servicios de registro y login
- Generación y validación de JWT
- Middleware de autenticación
- Rutas /auth/register y /auth/login

### Fase 3: CRUD Todos Backend (Día 3)
- Modelo Todo
- Servicio TodoService (CRUD completo)
- Controlador TodoController
- Rutas /todos (GET, POST, PUT, DELETE)
- Validaciones con express-validator

### Fase 4: Frontend Auth (Día 4)
- Configurar Redux Toolkit
- LoginForm y RegisterForm
- Hook useAuth
- Persistencia de sesión
- Rutas protegidas con React Router

### Fase 5: Frontend Todos (Día 5)
- TodoList, TodoItem, TodoForm
- Hook useTodos
- Filtros por estado
- Búsqueda por texto
- Estados de carga y error

### Fase 6: Tests y Polish (Día 6)
- Tests unitarios backend (Jest)
- Tests unitarios frontend (Vitest + Testing Library)
- Manejo de errores global
- Loading states y UX
- Documentación API

## Decisiones Técnicas

| Decisión | Elección | Razón |
|---|---|---|
| Estado global | Redux Toolkit | Manejo predecible de auth y todos |
| Validación | Zod + express-validator | Type-safe en ambos lados |
| ORM | Prisma | Type-safe queries, migraciones simples |
| Tests | Jest + Vitest | Estándares del ecosistema |
| Estilos | TailwindCSS | Desarrollo rápido y consistente |

## Riesgos
- **Seguridad JWT:** Mitigado con httpOnly cookies
- **Race conditions en todos:** Mitigado con optimistic updates
- **Performance DB:** Mitigado con índices en user_id y completed

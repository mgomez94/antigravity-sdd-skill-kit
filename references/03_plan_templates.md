# 03. Templates de Plan Técnico (plan.md)

## Template Base: plan.md

```markdown
# Plan Técnico: [Nombre de la Feature]

**Spec ID**: [NNN]
**Estado**: Draft | Approved
**Fecha**: [YYYY-MM-DD]
**Arquitecto**: [Nombre]

---

## 1. Resumen Arquitectónico

[Descripción en 3-5 oraciones de cómo se construirá esta feature desde el punto de vista técnico.]

---

## 2. Componentes Afectados

| Componente | Tipo | Acción | Descripción |
|---|---|---|---|
| [Nombre] | Frontend/Backend/DB/API | Crear/Modificar/Eliminar | [Descripción breve] |

---

## 3. Modelo de Datos

### Tablas Nuevas

```sql
CREATE TABLE [nombre_tabla] (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  [campo1] [TIPO] NOT NULL,
  [campo2] [TIPO],
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
```

### Tablas Modificadas

```sql
ALTER TABLE [nombre_tabla]
ADD COLUMN [nuevo_campo] [TIPO] [restricciones];
```

### Índices

```sql
CREATE INDEX idx_[tabla]_[campo] ON [tabla]([campo]);
```

---

## 4. Contratos de API

### Endpoint 1: [Método] [Ruta]

**Propósito**: [Qué hace]
**Autenticación**: [Requerida/No requerida]

**Request:**
```json
{
  "campo1": "string",
  "campo2": 0
}
```

**Response exitosa (200):**
```json
{
  "id": "uuid",
  "campo1": "string",
  "createdAt": "2026-01-01T00:00:00Z"
}
```

**Errores posibles:**
| Código | Mensaje | Causa |
|---|---|---|
| 400 | "[mensaje]" | [causa] |
| 401 | "Unauthorized" | Token inválido o ausente |
| 404 | "Not found" | Recurso no existe |
| 500 | "Internal server error" | Error del servidor |

---

## 5. Arquitectura de Componentes Frontend

```
src/
  components/
    [NombreFeature]/
      index.tsx           # Componente principal
      [NombreFeature].tsx # Lógica del componente
      [NombreFeature].test.tsx
      types.ts            # Tipos TypeScript
      hooks/
        use[NombreFeature].ts
  pages/
    [nombre-pagina]/
      index.tsx
  services/
    [nombre-feature].service.ts  # Llamadas a API
```

---

## 6. Arquitectura de Componentes Backend

```
src/
  routes/
    [nombre-feature].routes.ts
  controllers/
    [nombre-feature].controller.ts
  services/
    [nombre-feature].service.ts
  repositories/
    [nombre-feature].repository.ts
  models/
    [nombre-feature].model.ts
  middlewares/
    [nombre-feature].middleware.ts (si aplica)
  validators/
    [nombre-feature].validator.ts
```

---

## 7. Decisiones Técnicas y Trade-offs

| Decisión | Opción Elegida | Alternativas Consideradas | Razón |
|---|---|---|---|
| [Tipo de decisión] | [Lo que se elige] | [Alternativa 1, Alternativa 2] | [Por qué esta opción] |

---

## 8. Plan de Migración (si aplica)

### Migración de Base de Datos
- [ ] Crear migración: `[fecha]_[descripcion].sql`
- [ ] Script de rollback preparado
- [ ] Probado en entorno de staging

### Migración de Datos (si aplica)
- [ ] Script de migración de datos
- [ ] Verificación de integridad
- [ ] Plan de contingencia

---

## 9. Estrategia de Testing

### Unit Tests
- [ ] Servicio: [nombre].service.test.ts
- [ ] Repository: [nombre].repository.test.ts
- [ ] Cobertura objetivo: 80%

### Integration Tests
- [ ] API: [Método] [Ruta] - happy path
- [ ] API: [Método] [Ruta] - error cases

### E2E Tests (si aplica)
- [ ] Flujo completo: [descripción]

---

## 10. Riesgos Técnicos

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| [Descripción del riesgo] | Alta/Media/Baja | Alta/Media/Baja | [Plan de mitigación] |

---

## 11. Estimación

| Área | Horas estimadas |
|---|---|
| Backend | [N] horas |
| Frontend | [N] horas |
| Tests | [N] horas |
| Migración BD | [N] horas |
| **Total** | **[N] horas** |
```

---

## Ejemplo Completo: Feature "Sistema de Comentarios"

```markdown
# Plan Técnico: Sistema de Comentarios en Posts

**Spec ID**: 003
**Estado**: Approved
**Fecha**: 2026-03-01

## 1. Resumen Arquitectónico

Se implementará un sistema CRUD de comentarios con estructura clásica REST. El frontend usará React Query para manejo de estado asíncrono. El backend expone 4 endpoints RESTful. La BD agrega una tabla `comments` con FK a `posts` y `users`.

## 3. Modelo de Datos

```sql
CREATE TABLE comments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id),
  content TEXT NOT NULL CHECK (char_length(content) >= 10 AND char_length(content) <= 500),
  is_deleted BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_comments_post_id ON comments(post_id);
CREATE INDEX idx_comments_user_id ON comments(user_id);
```

## 4. Contratos de API

### POST /api/posts/:postId/comments

**Request:**
```json
{ "content": "Este es mi comentario" }
```

**Response (201):**
```json
{
  "id": "uuid",
  "postId": "uuid",
  "userId": "uuid",
  "content": "Este es mi comentario",
  "author": { "name": "Juan", "avatar": "url" },
  "createdAt": "2026-03-01T10:00:00Z"
}
```
```

---

## Checklist de Validación del Plan

- [ ] Todos los requisitos de spec.md están cubiertos
- [ ] Modelo de datos es consistente con la constitución
- [ ] Contratos de API definidos para todos los endpoints
- [ ] Estructura de carpetas sigue convenciones del proyecto
- [ ] Decisiones técnicas documentadas
- [ ] Riesgos identificados con mitigación
- [ ] Estimación realista

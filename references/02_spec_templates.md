# 02. Templates de Especificación (spec.md)

## Template Base: spec.md

Copia este template para cada nueva feature. Reemplaza todo lo que está entre `[corchetes]`.

---

```markdown
# Especificación: [Nombre de la Feature]

**ID**: [NNN]
**Estado**: Draft | In Review | Approved | Implemented
**Fecha**: [YYYY-MM-DD]
**Autor**: [Nombre]
**Revisor**: [Nombre]

---

## 1. Objetivo de Negocio

[Describe en 2-3 oraciones qué problema de negocio resuelve esta feature y por qué es importante.]

**Métrica de éxito**: [Cómo sabremos que esta feature fue exitosa? Ej: "tasa de conversión aumenta 10%"]

---

## 2. Contexto

[Proporciona el contexto necesario para entender la feature. Incluye:
- El estado actual del sistema
- Por qué se necesita este cambio
- Cualquier decisión previa relevante]

---

## 3. Usuarios y Roles

| Rol | Descripción | Permisos |
|---|---|---|
| [Rol 1] | [Descripción] | [Permisos] |
| [Rol 2] | [Descripción] | [Permisos] |

---

## 4. User Stories

### Historia 1: [Título]

**Como** [tipo de usuario]
**Quiero** [acción o funcionalidad]
**Para** [beneficio o valor]

#### Criterios de Aceptación

**Escenario 1: [Nombre del escenario - camino feliz]**
```
GIVEN [contexto o precondición]
AND [condición adicional si aplica]
WHEN [acción que realiza el usuario]
THEN [resultado esperado]
AND [resultado adicional si aplica]
```

**Escenario 2: [Nombre del escenario - caso alternativo]**
```
GIVEN [...]
WHEN [...]
THEN [...]
```

**Escenario 3: [Nombre del escenario - caso de error]**
```
GIVEN [...]
WHEN [...]
THEN [...]
```

### Historia 2: [Título]
[Repetir estructura...]

---

## 5. Requisitos Funcionales

| ID | Requisito | Prioridad | Historia |
|---|---|---|---|
| RF-001 | [Descripción clara del requisito] | Alta/Media/Baja | H1 |
| RF-002 | [Descripción clara del requisito] | Alta/Media/Baja | H1, H2 |

---

## 6. Requisitos No Funcionales

### Rendimiento
- [Ej: La página debe cargar en menos de 2 segundos]
- [Ej: La API debe responder en menos de 200ms para el 95% de las peticiones]

### Seguridad
- [Ej: Solo usuarios autenticados pueden acceder]
- [Ej: Los datos sensibles deben estar cifrados en tránsito y en reposo]

### Escalabilidad
- [Ej: Debe soportar hasta 1000 usuarios concurrentes]

### Disponibilidad
- [Ej: SLA del 99.9%, máximo 8.7 horas de downtime al año]

### Accesibilidad
- [Ej: Cumplir WCAG 2.1 nivel AA]

---

## 7. Casos Borde (Edge Cases)

| Caso | Comportamiento esperado |
|---|---|
| [Descripción del caso borde] | [Qué debe pasar] |
| [Usuario sin permisos intenta acceder] | [Redirigir a página de error 403] |
| [Input vacío o nulo] | [Mostrar mensaje de validación] |
| [Timeout de red] | [Mostrar mensaje de error con opción de reintentar] |

---

## 8. Dependencias

### Dependencias Internas
- [Feature o módulo del que depende esta feature]
- [Servicio interno requerido]

### Dependencias Externas
- [API de tercero: nombre, versión, propósito]
- [Librería: nombre, versión]

### Features que Dependen de Ésta
- [Otras features del backlog que dependen de esta]

---

## 9. Restricciones y Supuestos

### Restricciones
- [Restricción técnica, de negocio o de tiempo]

### Supuestos
- [Suposición que se está haciendo y que, si fuera falsa, afectaría la spec]

---

## 10. Diseño UI/UX (si aplica)

[Link a Figma/prototipo o descripción de la interfaz]

**Pantallas afectadas**:
- [Nombre de pantalla / ruta]

---

## 11. Preguntas Abiertas

| # | Pregunta | Responsable | Estado | Respuesta |
|---|---|---|---|---|
| 1 | [Pregunta que necesita respuesta] | [Nombre] | Pendiente | - |

---

## 12. Historial de Cambios

| Versión | Fecha | Autor | Cambio |
|---|---|---|---|
| 1.0 | [YYYY-MM-DD] | [Nombre] | Versión inicial |
```

---

## Ejemplo Completo: Feature "Sistema de Comentarios en Posts"

```markdown
# Especificación: Sistema de Comentarios en Posts

**ID**: 003
**Estado**: Approved
**Fecha**: 2026-03-01
**Autor**: mgomez94
**Revisor**: equipo-dev

---

## 1. Objetivo de Negocio

Permitir a los usuarios comentar en los posts del blog para aumentar el engagement y el tiempo en página.

**Métrica de éxito**: Tiempo promedio en página aumenta 40%, número de comentarios por post > 5 en el primer mes.

---

## 4. User Stories

### Historia 1: Crear Comentario

**Como** usuario autenticado
**Quiero** escribir un comentario en un post
**Para** compartir mi opinión con la comunidad

**Escenario 1: Comentario exitoso**
```
GIVEN que el usuario está autenticado
AND está viendo un post público
WHEN escribe un comentario de 10-500 caracteres y hace clic en "Publicar"
THEN el comentario aparece al final de la lista
AND se muestra la fecha y el nombre del usuario
AND se envía notificación por email al autor del post
```

**Escenario 2: Comentario muy corto**
```
GIVEN que el usuario escribe menos de 10 caracteres
WHEN intenta publicar
THEN se muestra el mensaje "El comentario debe tener al menos 10 caracteres"
AND el comentario no se publica
```

**Escenario 3: Usuario no autenticado**
```
GIVEN que el usuario no está autenticado
WHEN hace clic en el área de comentarios
THEN se muestra el modal de login
AND después del login exitoso, se redirige al post original
```
```

---

## Checklist de Validación antes de Aprobar la Spec

- [ ] Objetivo de negocio claro y medible
- [ ] Al menos 1 historia de usuario con criterios GIVEN-WHEN-THEN
- [ ] Requisitos no funcionales definidos (al menos rendimiento y seguridad)
- [ ] Casos borde identificados
- [ ] Dependencias listadas
- [ ] No hay ambigüedades sin resolver
- [ ] Revisada por al menos 1 persona adicional

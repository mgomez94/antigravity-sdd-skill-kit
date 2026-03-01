# SPEC — Todo App (Ejemplo SDD)

## Contexto del Proyecto
- **App:** Todo App con autenticación y persistencia
- **Stack:** React + TypeScript / Node.js + Express / PostgreSQL
- **Patrón:** SDD con Antigravity

## Objetivo
Construir una aplicación de tareas con autenticación de usuario, CRUD completo de tareas, y persistencia en base de datos.

## Usuarios y Roles
- **Usuario autenticado:** Crear, leer, actualizar y eliminar sus propias tareas
- **Visitante:** Solo puede ver la pantalla de login/registro

## Requerimientos Funcionales

### RF-001: Autenticación
- El usuario puede registrarse con email y contraseña
- El usuario puede iniciar sesión
- El usuario puede cerrar sesión
- Las rutas protegidas requieren token JWT válido

### RF-002: Gestión de Tareas
- El usuario puede crear una tarea con título y descripción opcional
- El usuario puede listar todas sus tareas
- El usuario puede marcar una tarea como completada
- El usuario puede editar el título y descripción de una tarea
- El usuario puede eliminar una tarea

### RF-003: Filtros
- El usuario puede filtrar tareas por estado (todas, activas, completadas)
- El usuario puede buscar tareas por texto

## Requerimientos No Funcionales
- Respuesta de API < 200ms en operaciones CRUD
- Cobertura de tests unitarios >= 80%
- Validación de inputs en frontend y backend
- Tokens JWT con expiración de 24h

## Criterios de Aceptación

### CA-001: Login exitoso
**Dado** que el usuario tiene cuenta registrada  
**Cuando** ingresa email y contraseña correctos  
**Entonces** recibe token JWT y es redirigido al dashboard  

### CA-002: Crear tarea
**Dado** que el usuario está autenticado  
**Cuando** completa el formulario de nueva tarea y confirma  
**Entonces** la tarea aparece en la lista con estado 'activa'  

### CA-003: Completar tarea
**Dado** que existe una tarea activa  
**Cuando** el usuario hace click en el checkbox  
**Entonces** la tarea pasa a estado 'completada' y se refleja visualmente  

## Restricciones Técnicas
- JWT almacenado en httpOnly cookie
- Passwords hasheadas con bcrypt (salt rounds: 12)
- Rate limiting: 100 requests/min por IP
- Inputs sanitizados con express-validator
- Variables de entorno en .env (nunca en código)

## Fuera de Alcance
- Compartir tareas entre usuarios
- Notificaciones push
- Modo offline
- Integración con calendarios externos

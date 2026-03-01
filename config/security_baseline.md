# Security Baseline — Obligatorio en todos los modos

> Este baseline aplica tanto a modo `startup` como `enterprise`. **No es negociable.** Generar software inseguro no es una opción, sea cual sea la velocidad requerida.

---

## 1. Autenticación y Autorización

- [ ] No implementar endpoints sensibles sin autenticación.
- [ ] Usar JWT, OAuth2 o mecanismo equivalente probado (no "tokens caseros").
- [ ] Roles y permisos definidos (admin, user, etc.); no lógica de permisos hardcodeada.
- [ ] Nunca confiar en datos del cliente para decisiones de autorización (siempre validar en backend).
- [ ] Tokens JWT con tiempo de expiración definido (máximo 24h para tokens de acceso).
- [ ] Refresh tokens almacenados en httpOnly cookies (nunca en localStorage).
- [ ] Implementar logout que invalide tokens activos.

## 2. Gestión de Datos Sensibles

- [ ] Nunca loguear contraseñas, tokens, claves API ni PII completa.
- [ ] Cifrar datos sensibles en reposo cuando aplique.
- [ ] Usar HTTPS/TLS en todos los entornos externos.
- [ ] Variables de entorno para secrets, nunca hardcodeadas en código fuente.
- [ ] Archivo `.env` en `.gitignore`, proveer solo `.env.example`.
- [ ] Passwords hasheadas con bcrypt (min 12 salt rounds) o argon2.
- [ ] Datos de tarjeta NUNCA pasan por servidores propios (usar Stripe/proveedor PCI).

## 3. Validación de Inputs

- [ ] Validar y sanear TODOS los inputs de usuario en el backend.
- [ ] Usar validadores estructurados (Zod, Joi, express-validator, etc.).
- [ ] Limitar tamaño máximo de payloads (ej: 10MB por defecto).
- [ ] Rechazar tipos/formatos inesperados con errores claros (400 Bad Request).
- [ ] Sanitizar HTML/texto para prevenir XSS antes de almacenar o renderizar.
- [ ] Nunca usar inputs sin validar en queries SQL, comandos de shell o paths de archivos.

## 4. Protección Web (OWASP Top 10)

### Prevención de XSS
- [ ] Escapar outputs en el frontend (React lo hace por defecto, evitar `dangerouslySetInnerHTML`).
- [ ] Configurar Content-Security-Policy (CSP) restrictivo.
- [ ] Usar nonces o hashes en CSP para scripts inline.

### Prevención de CSRF
- [ ] Usar tokens CSRF o cookies con atributo `SameSite=Strict` o `SameSite=Lax`.
- [ ] Validar el header `Origin` en endpoints mutables (POST, PUT, DELETE).

### Prevención de Inyección
- [ ] Usar ORMs/queries preparadas, nunca concatenar SQL o comandos.
- [ ] Validar y escapar parámetros de búsqueda en queries.
- [ ] Evitar `eval()`, `exec()`, y similares con datos del usuario.

### Rate Limiting
- [ ] Aplicar rate limiting en endpoints críticos (login, registro, reset password).
- [ ] Ej: máx 10 intentos de login por IP en 15 minutos.
- [ ] Implementar bloqueo temporal después de múltiples fallos.

### Otros OWASP
- [ ] Prevenir enumeración de usuarios (mensajes de error genéricos en login).
- [ ] Proteger contra Mass Assignment (usar DTOs / whitelist de campos permitidos).
- [ ] Implementar paginación en listados (nunca retornar toda la BD).

## 5. Configuración Segura del Servidor

- [ ] Deshabilitar dashboards de administración por defecto en producción.
- [ ] No exponer puertos internos directamente a internet.
- [ ] Configurar CORS solo para orígenes conocidos (nunca `*` en producción con credenciales).
- [ ] Headers de seguridad HTTP configurados (usar `helmet.js` en Node.js):
  - `X-Content-Type-Options: nosniff`
  - `X-Frame-Options: DENY`
  - `Strict-Transport-Security: max-age=31536000`
  - `Referrer-Policy: strict-origin-when-cross-origin`
- [ ] Timeouts configurados en el servidor (evitar conexiones colgadas).
- [ ] Deshabilitar modo debug en producción (no stack traces expuestos).

## 6. Dependencias y Supply Chain

- [ ] Auditar dependencias regularmente (`npm audit` / `yarn audit`).
- [ ] No usar librerías con vulnerabilidades críticas conocidas sin parche.
- [ ] Bloquear versiones exactas en `package-lock.json` o `yarn.lock`.
- [ ] No instalar dependencias de desarrollo en producción.

## 7. Testing de Seguridad

- [ ] Tests automáticos que verifican que endpoints críticos requieren autenticación.
- [ ] Tests que simulan ataques básicos (inputs malformados, tamaños extremos).
- [ ] Tests de rate limiting en endpoints críticos.
- [ ] En modo `enterprise`: revisión estática (SAST) y escaneo de vulnerabilidades.

## 8. Revisión Manual antes de DONE

Antes de marcar cualquier feature como **DONE**, verificar:

- [ ] No hay secrets en código fuente (buscar con `grep -r 'API_KEY\|SECRET\|PASSWORD' --include='*.ts' src/`).
- [ ] No se exponen datos de más en las respuestas de API (no devolver campos internos).
- [ ] Las rutas sensibles requieren autenticación y los permisos correctos.
- [ ] Los errores muestran mensajes genéricos al cliente (no stack traces).
- [ ] Los logs contienen información útil pero sin datos sensibles.

---

## Nota sobre el modo startup

Incluso en modo startup/MVP, este baseline completo aplica. La diferencia con enterprise no es saltarse la seguridad, sino:
- Priorizar las métricas mínimas en vez de observabilidad completa.
- No requerir tests de carga, pero sí tests de los flujos críticos.
- Arquitectura más simple, pero igualmente segura.

**Generar un MVP inseguro es generar deuda técnica crítica desde el día 1.**

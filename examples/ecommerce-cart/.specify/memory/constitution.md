# CONSTITUCIÓN DEL PROYECTO — Ecommerce Cart

## Identidad del Proyecto
- **Nombre:** Ecommerce Cart Module
- **Tipo:** Módulo de carrito de compras con checkout
- **Stack:** React + TypeScript / Node.js + Express / PostgreSQL
- **Patrón:** SDD con Antigravity

## Propósito
Implementar un módulo de carrito de compras completo con gestión de productos, carrito persistente, proceso de checkout y integración de pagos.

## Principios de Diseño
- **UX primero:** El flujo de compra debe ser intuitivo y rápido (máximo 3 pasos)
- **Persistencia:** El carrito sobrevive cierres de sesión
- **Rendimiento:** Catálogo carga en < 1.5s incluso con 1000+ productos
- **Seguridad:** Validación de precios siempre en backend

## Stack y Decisiones Arquitectónicas

### Frontend
- React 18 + TypeScript
- Redux Toolkit para estado del carrito
- React Query para datos del catálogo
- TailwindCSS para estilos
- Stripe Elements para pagos

### Backend
- Node.js + Express + TypeScript
- Prisma ORM
- PostgreSQL para persistencia
- Redis para sesión de carrito anónimo
- Stripe SDK para procesamiento de pagos

### Base de Datos
- PostgreSQL: productos, órdenes, usuarios
- Redis: carrito temporal (TTL 7 días)

## Restricciones Críticas
- NUNCA confiar en precios del frontend: siempre recalcular en backend
- Inventario debe verificarse en checkout, no solo al agregar al carrito
- Datos de tarjeta NUNCA pasan por nuestros servidores (solo Stripe tokens)
- Transacciones de pago son atómicas: crear orden + procesar pago en una transacción
- Rate limiting estricto en endpoints de checkout (10 req/min por usuario)

## Flujo Principal
1. Usuario navega catálogo → filtra y busca productos
2. Agrega productos al carrito (persistente)
3. Revisa carrito y aplica cupones
4. Proceso de checkout: datos de envío
5. Pago con Stripe
6. Confirmación y notificación por email

## Contexto de Negocio
- Convertir visitantes en compradores con mínima fricción
- Soportar cupones de descuento
- Inventario en tiempo real
- Historial de órdenes para usuarios registrados

## Convenciones de Código
- Commits: Conventional Commits (feat, fix, chore, test)
- Branches: feature/nombre, fix/nombre
- Tests: al menos 80% de cobertura en servicios críticos (pago, inventario)
- PR reviews: requerido para merge a main
- Documentación: JSDoc en funciones públicas

## Fuera de Alcance
- Múltiples monedas
- Programa de lealtad / puntos
- Suscripciones recurrentes
- App móvil nativa
- Marketplace multi-vendedor

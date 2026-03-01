# SPEC — Ecommerce Cart Module

## Contexto del Proyecto
- **App:** Módulo de carrito de compras con checkout completo
- **Stack:** React + TypeScript / Node.js + Express / PostgreSQL + Redis
- **Patrón:** SDD con Antigravity

## Objetivo
Desarrollar un módulo de ecommerce que permita a usuarios navegar un catálogo, gestionar su carrito, aplicar descuentos y completar compras de forma segura.

## Usuarios y Roles
- **Comprador anónimo:** Navegar catálogo, agregar al carrito (carrito temporal)
- **Comprador registrado:** Carrito persistente, historial de órdenes, dirección guardada
- **Admin:** Gestionar productos e inventario (fuera del scope actual)

## Requerimientos Funcionales

### RF-001: Catálogo de Productos
- El usuario puede ver una lista de productos con imagen, nombre, precio y stock
- El usuario puede filtrar por categoría
- El usuario puede buscar productos por nombre
- El usuario puede ver el detalle de un producto
- Los productos sin stock muestran badge 'Agotado'

### RF-002: Carrito de Compras
- El usuario puede agregar productos al carrito
- El usuario puede cambiar la cantidad de cada producto
- El usuario puede eliminar productos del carrito
- El carrito muestra subtotal, impuestos y total
- El carrito persiste entre sesiones (registrado) o en localStorage (anónimo)
- Al registrarse/loguearse se fusiona el carrito anónimo con el del usuario

### RF-003: Cupones de Descuento
- El usuario puede aplicar un código de cupón
- El sistema valida el cupón (existente, vigente, no usado)
- Los descuentos pueden ser porcentaje o monto fijo
- Solo se puede aplicar un cupón por orden

### RF-004: Proceso de Checkout
- El usuario ingresa dirección de envío
- El sistema calcula costo de envío según destino
- El usuario ingresa datos de pago (Stripe Elements)
- El sistema procesa el pago
- Si pago exitoso: crear orden, reducir inventario, enviar email
- Si pago fallido: mantener carrito intacto, mostrar error

### RF-005: Órdenes
- El usuario puede ver su historial de órdenes
- El usuario puede ver el detalle de una orden
- Las órdenes tienen estados: pending, confirmed, shipped, delivered

## Requerimientos No Funcionales
- Catálogo carga en < 1.5s (páginación de 20 productos)
- Proceso de pago completa en < 5s
- Disponibilidad 99.9%
- Cifrado TLS para toda comunicación

## Criterios de Aceptación

### CA-001: Agregar al carrito
**Dado** que el producto tiene stock disponible  
**Cuando** el usuario hace click en 'Agregar al carrito'  
**Entonces** el producto aparece en el carrito y el contador se actualiza  

### CA-002: Checkout exitoso
**Dado** que el usuario tiene productos en el carrito y datos de pago válidos  
**Cuando** confirma la compra  
**Entonces** se crea la orden, se reduce el inventario y llega email de confirmación  

### CA-003: Cupón inválido
**Dado** que el usuario ingresa un código de cupón incorrecto o expirado  
**Cuando** intenta aplicarlo  
**Entonces** ve un mensaje de error descriptivo y el total no cambia  

### CA-004: Stock insuficiente en checkout
**Dado** que el stock de un producto cambió entre que lo agregó al carrito y el checkout  
**Cuando** intenta confirmar la compra  
**Entonces** ve un aviso del producto afectado y puede ajustar el carrito  

## Restricciones Técnicas
- Precios siempre recalculados en backend (nunca confiar en frontend)
- Datos de tarjeta solo via Stripe Elements (PCI compliant)
- Transacción atómica: pago + orden + inventario
- Rate limiting: 10 req/min en /checkout
- Inventario verificado en el momento del pago, no solo al agregar al carrito

## Fuera de Alcance
- Múltiples monedas
- Marketplace multi-vendedor
- Suscripciones
- App móvil
- Programa de puntos

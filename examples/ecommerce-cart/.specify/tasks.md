# TASKS — Ecommerce Cart Module

## Sprint 1: Catálogo y Carrito Backend

### TASK-001: API de Productos
- **Estado:** TODO
- **Estimación:** 3h
- **Checklist:**
  - [ ] Modelo Product con Prisma
  - [ ] ProductService.findAll(filters, pagination)
  - [ ] ProductService.findById(id)
  - [ ] GET /products con query params (category, search, page, limit)
  - [ ] GET /products/:id
  - [ ] Índices en category y name
  - [ ] Tests ProductService

### TASK-002: API de Carrito
- **Estado:** TODO
- **Estimación:** 4h
- **Checklist:**
  - [ ] Modelo Cart y CartItem con Prisma
  - [ ] CartService.getOrCreate(userId | sessionId)
  - [ ] CartService.addItem(cartId, productId, qty)
  - [ ] CartService.updateItem(cartId, itemId, qty)
  - [ ] CartService.removeItem(cartId, itemId)
  - [ ] CartService.calculateTotals(cartId)
  - [ ] POST/GET/PUT/DELETE /cart endpoints
  - [ ] Fusión de carrito anónimo al login

### TASK-003: API de Cupones
- **Estado:** TODO
- **Estimación:** 2h
- **Checklist:**
  - [ ] Modelo Coupon (code, type, value, expiry, usageLimit)
  - [ ] CouponService.validate(code, cartTotal)
  - [ ] CouponService.apply(cartId, couponCode)
  - [ ] POST /cart/coupon
  - [ ] DELETE /cart/coupon
  - [ ] Tests con cupón válido, expirado e inválido

## Sprint 2: Checkout e Integración Stripe

### TASK-004: Integración Stripe Backend
- **Estado:** TODO
- **Estimación:** 4h
- **Checklist:**
  - [ ] Instalar Stripe SDK
  - [ ] StripeService.createPaymentIntent(amount, currency)
  - [ ] StripeService.confirmPayment(paymentIntentId)
  - [ ] Webhook handler para eventos de Stripe
  - [ ] Manejo de pagos fallidos
  - [ ] Tests con Stripe test mode

### TASK-005: Checkout Atómico
- **Estado:** TODO
- **Estimación:** 5h
- **Checklist:**
  - [ ] CheckoutService.processOrder(cartId, shippingData, paymentMethodId)
  - [ ] Verificación de stock en el momento del pago (lock pesimista)
  - [ ] Recalcular precios desde DB (nunca confiar en frontend)
  - [ ] Transacción atómica: crear orden + pagar + reducir stock
  - [ ] Rollback si el pago falla
  - [ ] EmailService.sendOrderConfirmation(order)
  - [ ] POST /checkout endpoint con rate limiting
  - [ ] Tests de integración checkout

## Sprint 3: Frontend

### TASK-006: Catálogo Frontend
- **Estado:** TODO
- **Estimación:** 4h
- **Checklist:**
  - [ ] ProductGrid con paginación infinita o por páginas
  - [ ] ProductCard con imagen, precio, stock badge
  - [ ] SearchBar con debounce
  - [ ] ProductFilters por categoría
  - [ ] Hook useCatalog con React Query
  - [ ] Estado de carga y error

### TASK-007: Carrito Frontend
- **Estado:** TODO
- **Estimación:** 4h
- **Checklist:**
  - [ ] CartDrawer con slide-over
  - [ ] CartItem con control de cantidad
  - [ ] CartSummary (subtotal, impuesto, envío, total)
  - [ ] CouponInput con feedback visual
  - [ ] Hook useCart con Redux
  - [ ] Persistencia en localStorage (usuario anónimo)
  - [ ] Sincronización con backend al hacer login

### TASK-008: Checkout Frontend
- **Estado:** TODO
- **Estimación:** 5h
- **Checklist:**
  - [ ] ShippingForm con validación
  - [ ] PaymentForm con Stripe Elements
  - [ ] OrderSummary en checkout
  - [ ] Estados: loading, success, error
  - [ ] Página de confirmación post-pago
  - [ ] Manejo de errores de pago con mensajes descriptivos

### TASK-009: Historial de Órdenes
- **Estado:** TODO
- **Estimación:** 2h
- **Checklist:**
  - [ ] OrderHistory con listado paginado
  - [ ] OrderDetail con estado y productos
  - [ ] Hook useOrders con React Query

## Sprint 4: Tests y Calidad

### TASK-010: Tests Críticos
- **Estado:** TODO
- **Estimación:** 4h
- **Checklist:**
  - [ ] Test: pago exitoso crea orden y reduce stock
  - [ ] Test: pago fallido mantiene carrito y no crea orden
  - [ ] Test: cupón expirado rechazado
  - [ ] Test: stock insuficiente en checkout bloqueado
  - [ ] Test: precios del frontend ignorados (usa precios DB)
  - [ ] Cobertura >= 80% en CheckoutService e InventoryService

## Definición de Hecho (DoD)
- [ ] Tests pasando, cobertura >= 80% en servicios críticos
- [ ] Sin errores TypeScript
- [ ] Flujo de pago probado en Stripe test mode
- [ ] Race conditions de inventario verificadas
- [ ] Datos de tarjeta nunca en logs ni DB propia

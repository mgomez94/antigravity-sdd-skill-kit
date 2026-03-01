# PLAN — Ecommerce Cart Module

## Arquitectura General

### Frontend (React + TypeScript)
```
src/
  components/
    Catalog/
      ProductGrid.tsx
      ProductCard.tsx
      ProductDetail.tsx
      ProductFilters.tsx
      SearchBar.tsx
    Cart/
      CartDrawer.tsx
      CartItem.tsx
      CartSummary.tsx
      CouponInput.tsx
    Checkout/
      CheckoutForm.tsx
      ShippingForm.tsx
      PaymentForm.tsx  (Stripe Elements)
      OrderSummary.tsx
    Orders/
      OrderHistory.tsx
      OrderDetail.tsx
  hooks/
    useCart.ts
    useCatalog.ts
    useCheckout.ts
    useOrders.ts
  store/
    cart.slice.ts
    checkout.slice.ts
  services/
    product.service.ts
    cart.service.ts
    order.service.ts
    stripe.service.ts
  types/
    product.types.ts
    cart.types.ts
    order.types.ts
```

### Backend (Node.js + Express)
```
src/
  controllers/
    product.controller.ts
    cart.controller.ts
    coupon.controller.ts
    checkout.controller.ts
    order.controller.ts
  services/
    product.service.ts
    cart.service.ts
    coupon.service.ts
    checkout.service.ts
    inventory.service.ts
    stripe.service.ts
    email.service.ts
  middleware/
    auth.middleware.ts
    rateLimit.middleware.ts
  routes/
    products.routes.ts
    cart.routes.ts
    checkout.routes.ts
    orders.routes.ts
```

### Base de Datos
```sql
-- productos
CREATE TABLE products (
  id UUID PRIMARY KEY,
  name VARCHAR(500) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  stock INTEGER DEFAULT 0,
  category VARCHAR(100),
  image_url VARCHAR(1000),
  created_at TIMESTAMP DEFAULT NOW()
);

-- carritos
CREATE TABLE carts (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  session_id VARCHAR(255),
  coupon_id UUID REFERENCES coupons(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- items del carrito
CREATE TABLE cart_items (
  id UUID PRIMARY KEY,
  cart_id UUID REFERENCES carts(id),
  product_id UUID REFERENCES products(id),
  quantity INTEGER NOT NULL,
  price_snapshot DECIMAL(10,2) NOT NULL
);

-- órdenes
CREATE TABLE orders (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  status order_status DEFAULT 'pending',
  total DECIMAL(10,2),
  stripe_payment_id VARCHAR(255),
  shipping_address JSONB,
  created_at TIMESTAMP DEFAULT NOW()
);
```

## Fases de Implementación

### Fase 1: Catálogo (Días 1-2)
- API de productos con filtros y paginación
- Componentes ProductGrid y ProductCard
- Filtros por categoría y búsqueda

### Fase 2: Carrito (Días 3-4)
- API de carrito (crear, agregar, actualizar, eliminar)
- CartDrawer y CartItem en frontend
- Persistencia y fusión de carrito anónimo
- API de cupones y validación

### Fase 3: Checkout (Días 5-6)
- Integración Stripe Elements
- Flujo de checkout (shipping + payment)
- Lógica atómica: pago + orden + inventario
- Emails de confirmación

### Fase 4: Órdenes y Polish (Día 7)
- Historial de órdenes
- Tests críticos
- Manejo de errores global

## Decisiones Técnicas

| Decisión | Elección | Razón |
|---|---|---|
| Pagos | Stripe | PCI compliant, SDK robusto |
| Caché carrito | Redis | TTL flexible, rápido |
| Datos async | React Query | Caché y revalidación automática |
| Email | Nodemailer + SendGrid | Confiabilidad |
| Inventario | Lock pesimista | Evita race conditions en checkout |

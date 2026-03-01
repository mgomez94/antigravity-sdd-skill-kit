# Constitución del Proyecto: Todo App

**Proyecto**: Todo App - Aplicación de gestión de tareas
**Fecha**: 2026-03-01
**Stack**: React + TypeScript | Node.js + Express | PostgreSQL | Docker

---

## 1. Tipo de Proyecto

Aplicación web full-stack para gestión personal de tareas con autenticación de usuarios.

## 2. Stack Tecnológico

### Frontend
- Framework: React 18 + TypeScript
- Estilos: TailwindCSS
- Estado: React Query v5 + Zustand
- Testing: Vitest + Testing Library
- Build: Vite

### Backend
- Runtime: Node.js 20
- Framework: Express + TypeScript
- ORM: Prisma
- Auth: JWT + bcrypt
- Testing: Jest + Supertest

### Base de Datos
- Principal: PostgreSQL 16
- Migraciones: Prisma Migrate

### Infraestructura
- Contenedores: Docker + Docker Compose
- CI/CD: GitHub Actions
- Deploy: Railway o Render

## 3. Principios Arquitectónicos

- Arquitectura en capas: Routes → Controllers → Services → Repositories
- Separación estricta frontend/backend
- API RESTful con versionado `/api/v1/`
- Autenticación con JWT (access + refresh tokens)
- CORS configurado solo para dominios conocidos

## 4. Estándares de Código

- Linting: ESLint + Prettier
- Commits: Conventional Commits
- Cobertura de tests: mínimo 80%
- Code review requerido para merge a main
- No hacer commit directamente a main

## 5. Restricciones de Seguridad

- Passwords hasheados con bcrypt (min 12 rounds)
- JWT expira en 15 minutos (access token)
- Refresh token expira en 7 días
- Rate limiting en endpoints de auth (5 intentos/min)
- Inputs sanitizados antes de queries
- Variables sensibles solo en .env

## 6. Restricciones de Rendimiento

- API response time: < 200ms p95
- Frontend LCP: < 2.5s
- N+1 queries prohibidos
- Páginas con más de 50 items: paginación obligatoria

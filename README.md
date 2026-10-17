# API Manager School

API REST para la gestión de estudiantes y usuarios de una institución educativa. Incluye autenticación con JWT, roles y permisos, paginación y pruebas de integración.

## Stack

- Ruby on Rails 7 (API mode)
- PostgreSQL 14
- Devise + devise-jwt
- RSpec, FactoryBot y Faker
- Docker y Docker Compose

## Modelos

- `Person`: datos personales del estudiante.
- `Student`: estudiante, asociado a una persona.
- `User`: cuenta de acceso.
- `Role` y `UsersRole`: roles asignados a cada usuario.

Roles disponibles: `student`, `manager`, `profesor` y `representative`.

## Endpoints

Base: `/api`.

| Método | Ruta | Descripción |
| --- | --- | --- |
| `POST` | `/api/users/sign_in` | Iniciar sesión y obtener el token JWT. |
| `DELETE` | `/api/users/sign_out` | Cerrar sesión. |
| `GET` | `/api/students` | Listar estudiantes (paginado). |
| `GET` | `/api/students/:id` | Ver un estudiante. |
| `POST` | `/api/students` | Crear un estudiante. |
| `PATCH` | `/api/students/:id` | Actualizar un estudiante. |
| `DELETE` | `/api/students/:id` | Eliminar un estudiante. |

Permisos:

- `GET /api/students` y `GET /api/students/:id`: `manager`, `profesor` y `representative`.
- `POST`, `PATCH` y `DELETE`: `manager` y `profesor`.

Las rutas protegidas esperan el token en el header `Authorization: Bearer <token>`.

## Uso con Docker

```bash
cp .env.example .env
# edita .env con tus credenciales

docker compose build
docker compose run web rails db:create db:migrate db:seed
docker compose up -d
```

La API queda disponible en [http://localhost:3000](http://localhost:3000).

## Pruebas

```bash
docker compose exec web rspec
```

## Integración continua

El workflow `.github/workflows/ci.yml` ejecuta las pruebas en cada push o pull request.

# StockFlow

CRUD de produtos com filtros, ordenação e validações.

## Requisitos

- Docker
- Docker Compose

> Não é necessário ter Ruby, Rails ou PostgreSQL instalados localmente. Tudo roda dentro dos containers Docker.

## Instalando o Docker

Acesse o site oficial: https://docs.docker.com/get-docker/

Escolha o instalador para seu sistema operacional e verifique com:

```bash
docker --version
docker compose version
```

## Clonando o repositório

```bash
git clone https://github.com/Diolovedio/rails_setup_project.git
cd rails_setup_project
```

## Configurando as Variáveis de Ambiente

O arquivo `.env` não é versionado. Crie-o na raiz do projeto:

```bash
touch .env
```

Preencha com os valores:

```
DB_USERNAME=postgres
DB_PASSWORD=password
DB_HOST=db
REDIS_URL=redis://redis:6379/0
```

## Subindo o Projeto

### Opção 1 — Com Make

```bash
make up
```

### Opção 2 — Com Docker Compose

```bash
docker compose build
docker compose up
```

> O banco de dados é criado e as migrations são executadas automaticamente via `db:prepare` ao subir o container.

## Acessando a aplicação

| Serviço         | URL                       |
|-----------------|---------------------------|
| Aplicação Rails | https://localhost/        |
| Sidekiq Web UI  | https://localhost/sidekiq |

> Requisições HTTP (`http://localhost`) são redirecionadas automaticamente para HTTPS (`https://localhost`) com status 301.

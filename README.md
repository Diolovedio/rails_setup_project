# README

* Ruby version
ruby 3.4.9 (2026-03-11 revision 76cca827ab) +PRISM [x86_64-linux]

* Pré requisitos:
-Ruby
-Ruby on Rails
-PostgreSQL
-Bundler
-Git
-Docker

Dica: Não é necessário ter Ruby, Rails ou PostgreSQL instalados localmente. Tudo roda dentro dos containers Docker.

* Instalando o Docker
Acesse o site oficial: https://docs.docker.com/get-docker/
Escolha o instalador para seu sistema operacional (Linux, macOS ou Windows).
Siga as instruções de instalação e verifique com:

docker --version
docker compose version


* Clonando e acessando o repositório:
- git clone https://github.com/Diolovedio/rails_setup_project.git
- Cd rails_setup_project


*Configurando as Variáveis de Ambiente

O projeto usa um arquivo `.env` para variáveis sensíveis. Esse arquivo **não é versionado** (está no `.gitignore`). Crie-o a partir do exemplo:

```bash
cp .env.example .env
```
Abra o .env no seu editor e preencha os valores:
- RAILS_ENV=development
- DB_USERNAME=postgres
- DB_PASSWORD=password
- DB_HOST=db
- REDIS_URL=redis://redis:6379/0



Subindo o Projeto

### Passo 1 — Build dos containers

```bash
docker compose build
```

> Necessário apenas na primeira vez ou quando o `Dockerfile` mudar.

### Passo 2 — Criar e configurar o banco de dados

```bash
# Criar o banco de dados
docker compose run --rm web rails db:create

# Rodar as migrations
docker compose run --rm web rails db:migrate
```

### Passo 3 — Subir todos os serviços

```bash
# Em foreground (ver logs em tempo real)
docker compose up
```

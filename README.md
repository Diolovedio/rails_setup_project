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
 
* instale as dependências:
- bundle install


*Subindo o Projeto*
- docker compose up

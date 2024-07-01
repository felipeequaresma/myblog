# MyBlog
## Documentação da API
https://documenter.getpostman.com/view/12239354/2sA3duHE1e

# Configurando o projeto via docker

## Requisitos
- docker
- docker-compose

## Setup de variaveis ambiente

Antes de tudo precisamos criar um arquivo com as variáveis de ambiente do projeto. Os valores dessas variaveis em produção são secretas, portanto qualquer modificação das variaveis tera efeito apenas no seu ambiente local. Para isso precisamos rodar o comando:

```
$ cp .env.docker.sample .env.docker
```

Caso seja necessario adicionar novas variáveis de ambiente para serem usadas em desenvolvimento, adicione no arquivo `.env.docker.sample`, já que o arquivo `.env.docker` não é monitorado pelo git.

## Setup do docker-compose

Antes de iniciar o projeto precisamos montar os containers, para isso basta rodar o seguinte comando na pasta do projeto

```
$ docker-compose build
```

## Setup do banco de dados

Primeiro precisamos criar o banco, podemos fazer isso com o comando

```
$ docker-compose exec web rails db:create
```

Depois disso ainda no container podemos rodar as migrações do projeto com o comando:

```
$ docker-compose exec web rails db:migrate
$ docker-compose exec web rails db:seed
```

com isso o projeto estaconfigurado, e podemos subir o servidor com o comando:

```
$ docker-compose up
```

O sistema deve estar disponivel na url `localhot:3000` e possui 2 usuarios cadastradas:

E para interagir com a aplicação via terminal:


## Setup do ambiente de testes
Depois de finalizar o ambiente de desenvolvimento precisamos apenas do setup do banco de testesm, ainda dentro do container execute o comando:

```
$ RAILS_ENV=test rails db:create db:schema:load
```

Com isso podemos executar os testes com o comando:

```
$ docker-compose exec web rspec
```


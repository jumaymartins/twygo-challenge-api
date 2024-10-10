# twygo-challenge-api

## Technologies
- Ruby
- Rails
- PostgreSQL
- Docker

## Prerequisites
Is necessary that you have installed docker to run this application

You can install following follow doc: https://docs.docker.com/engine/

I recommend installing without Docker Desktop, because its only free for personal uses

## How to run application first time
`docker compose build`

`docker compose run web rake db:create`

`docker compose up`

## How to run database migrations
With web and db container running, you run command bellow:

`docker compose run web rake db:migrate`

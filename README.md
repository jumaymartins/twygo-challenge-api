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

## How to run tests
You can run all tests by using command bellow:

`docker compose exec web rails test`

Or you can run one test file specifind it path in command bellow:

`docker compose exec web rails test test_path`

All command is using `exec` that will only work if you have already a web container running
If you want to create a new container to run tests, you can replace `exec` by `run`


## Make
If you prefer, this project has make configurated for simple commands

You can see all available commands here: https://github.com/jumaymartins/twygo-challenge-api/blob/main/Makefile

To use make, you have to install it with bellow commands:

```
sudo apt-get update
sudo apt-get install make
```
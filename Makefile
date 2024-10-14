#!/bin/sh

USERNAME := $(USER)

# this command will add you as owner of all files of project
# it helps when you use commands through docker that creates new files,
# this results in files that, by default, the owner is the docker user
# For example, you will have this problem than you use command to generate
# migrations
fix_files_permittions:
	@sudo chown -R $(USERNAME):$(USERNAME) .

# You can pass test file path in this command to only execute the file path passed
tests:
	@docker compose exec web bundle exec rspec $(filter-out $@,$(MAKECMDGOALS))

create-db:
	@docker compose exec web rake db:create

migrate:
	@docker compose exec web rake db:migrate

rubocop:
	@docker compose exec web rubocop

console:
	@docker compose exec web rails console


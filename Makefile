MUTAGEN_SYNC_NAME=get-cured-soon-backend

start:
	docker-compose up -d

install:
	docker-compose up --build -d
	mutagen sync create --name=$(MUTAGEN_SYNC_NAME) app docker://getcuredsoon-php-fpm/application

prune:
	docker-compose down
	mutagen sync terminate --all

bash:
	docker-compose exec php-fpm bash

phpstan:
	docker-compose exec php-fpm vendor/bin/phpstan -cphpstan.neon

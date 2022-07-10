MUTAGEN_SYNC_NAME=get-cured-soon-backend
DC_EXEC=docker-compose exec php-fpm

start:
	docker-compose up -d

install:
	docker-compose up --build -d
	mutagen sync create --name=$(MUTAGEN_SYNC_NAME) app docker://getcuredsoon-php-fpm/application

prune:
	docker-compose down
	mutagen sync terminate --all

check-sync:
	mutagen sync list

bash:
	${DC_EXEC} bash

phpstan:
	${DC_EXEC} vendor/bin/phpstan -cphpstan.neon

phpmd:
	${DC_EXEC} vendor/bin/phpmd src text cleancode, codesize, controversial, design, naming, unusedcode

phpcs:
	${DC_EXEC} vendor/bin/phpcs --standard=PSR12 src

migration-new:
	${DC_EXEC} bin/console make:migration

migrate:
	${DC_EXEC} bin/console d:m:m -n

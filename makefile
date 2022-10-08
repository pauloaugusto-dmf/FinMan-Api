up:
	docker-compose up -d

up-logs:
	docker-compose up

down:
	docker-compose down

db-create:
	docker-compose exec web rails db:create

db-migrate:
	docker-compose exec web rails db:migrate

console:
	docker-compose exec web rails c

test:
	docker-compose exec web rspec

logs:
	docker-compose logs

bundle:
	docker-compose exec web bundle
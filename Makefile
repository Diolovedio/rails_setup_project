up:
	docker compose up

down:
	docker compose down

console:
	docker compose run --rm web bin/rails console

test:
	docker compose run --rm web bin/rails test

logs:
	docker compose logs -f

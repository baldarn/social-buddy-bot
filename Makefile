deploy:
	ssh -A baldarn@cervellone.lan "cd projects/bot-friend; git pull; exit"
	ssh baldarn@cervellone.lan "cd projects/bot-friend; docker compose --env-file .env.production up --build -d; exit"
	# ssh baldarn@cervellone.lan "cd projects/bot-friend; docker exec daruma whenever --update-crontab; exit"

dev:
	docker compose up -d --build
	docker image prune -f

console:
	docker exec -it bot-friend rails c

test-env:
	docker compose down
	docker compose --env-file .env.test up -d --build web redis
	docker image prune -f

test: test-env
	docker exec -it bot-friend rails test

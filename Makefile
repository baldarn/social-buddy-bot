USER_AND_HOST = baldarn@cervellone.lan
# USER_AND_HOST = ubuntu@54.155.243.223

deploy:
	ssh $(USER_AND_HOST) "sudo apt update && sudo apt install -y docker.io docker-compose; exit"
	ssh $(USER_AND_HOST) "mkdir -p projects; exit"
	ssh $(USER_AND_HOST) "ssh-keygen -F github.com || ssh-keyscan github.com >>~/.ssh/known_hosts"
	ssh -A $(USER_AND_HOST) "cd projects; ([ ! -d 'social-buddy-bot' ] && git clone git@github.com:42-monkeys/social-buddy-bot.git) || true; exit"
	scp web/config/master.key $(USER_AND_HOST):
	ssh $(USER_AND_HOST) "mv master.key projects/social-buddy-bot/web/config; exit"
	scp .env.production $(USER_AND_HOST):
	ssh $(USER_AND_HOST) "mv .env.production projects/social-buddy-bot/; exit"
	ssh -A $(USER_AND_HOST) "cd projects/social-buddy-bot; git pull; exit"
	ssh $(USER_AND_HOST) "cd projects/social-buddy-bot; sudo docker-compose --env-file .env.production up --build -d; exit"
	ssh $(USER_AND_HOST) "cd projects/social-buddy-bot; sudo docker exec social-buddy-bot whenever --update-crontab; exit"

dev:
	docker compose up -d --build
	docker image prune -f

exec:
	docker exec -it social-buddy-bot $(cmd)

attach:
	docker attach social-buddy-bot

test-env:
	docker compose down
	docker compose --env-file .env.test up -d --build web redis
	docker exec -it social-buddy-bot rails db:migrate
	docker image prune -f

test: test-env
	docker exec -it social-buddy-bot rails test

# Social Buddy Bot

A friendly bot for communications system (like Slack, Teams, ...) that enhance the conviviality between workers all around the world!


## Slack installation

You need to add the following scopes to the bot:

```scopes
channels:join
reactions:read
users:read
```

## Discord installation

You need to add the following scopes to the bot:

```scopes
bot
```

and the following permissions

```permissions
send messages
read message history
```

## Teams installation

Work in progress... ;)

## Dev

launch:

```shell
make dev
```

## Test

launch:

```shell
make test
```

## Deploy

You must edit the `deploy` section of your make file with your `USER_AND_HOST`

The machine must have docker and docker compose installed.

The script will generate a folder named `projects` and inside will copy the code and execute the `docker-compose`

The application will be exposed on the port `3333` of your machine

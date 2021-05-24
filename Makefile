.PHONY: server client

server:
	doppler run --command="docker compose -f docker-compose.yaml -f docker-compose.dev.yaml up"

client:
	(cd client && webdev serve)
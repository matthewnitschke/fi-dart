.PHONY: server client

server:
	doppler run --command="docker compose -f docker-compose.yaml -f docker-compose.dev.yaml up"

server-build:
	doppler run --command="docker compose -f docker-compose.yaml -f docker-compose.dev.yaml build"

client:
	(cd client && pub run build_runner watch -o build)
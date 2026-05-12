#!make
include .env

build:
	sudo docker build -t $(DOCKER_IMAGE_NAME) .

test:
	sudo docker compose up -d
	curl -f http://localhost:8090
	sudo docker compose down

publish: build test
	sudo docker login ghcr.io
	sudo docker push $(DOCKER_IMAGE_NAME)

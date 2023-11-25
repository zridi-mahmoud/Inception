COMPOSE_FILE = srcs/docker-compose.yaml
DOCKER_COMPOSE = docker-compose -f $(COMPOSE_FILE)
REPO_PATH = /home/mzridi


all: up

volumes:
	mkdir -p $(REPO_PATH)/data $(REPO_PATH)/data_i
up: volumes
	$(DOCKER_COMPOSE) up --build -d

clean: volumes
	$(DOCKER_COMPOSE) down

fclean: clean
	sudo rm -rf $(REPO_PATH)/data $(REPO_PATH)/data_db
re: clean build up

COMPOSE_FILE = srcs/docker-compose.yml
NAME = inception
COMPOSE = docker compose #-p $(NAME)

export COMPOSE_FILE

all: up

up: build
	$(COMPOSE) up --detach

build: volumes
	$(COMPOSE) build

ps:
	$(COMPOSE) ps -a

logs:
	$(COMPOSE) logs

volumes:
	mkdir -p /home/sflechel/data/wordpress
	mkdir -p /home/sflechel/data/mariadb

down:
	$(COMPOSE) down --timeout 2

clean: down
ifneq ($(shell docker images -q),)
	docker rmi $(shell docker images -q)
endif

fclean: clean
ifneq ($(shell docker volume ls -q),)
	docker volume rm $(shell docker volume ls -q)
endif
	sudo rm -rf /home/sflechel/data

reboot: down up

re: fclean up

prune: fclean
	docker system prune -af

.PHONY: all up down build ps prune re volumes create clean logs reboot

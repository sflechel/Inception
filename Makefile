NAME = inception
COMPOSE = docker compose -p $(NAME)

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
	mkdir -p ~/data/wordpress
	mkdir -p ~/data/mariadb

down:
	$(COMPOSE) down

clean: down
ifneq ($(docker images -q),)
	docker rmi $(docker images -q)
endif

fclean: clean
ifneq ($(docker volume ls),)
	docker volume rm $(docker volume ls)
endif
	sudo rm -rf ~/data

reboot: down up

re: fclean up

prune: fclean
	docker system prune -af

.PHONY: all up down build ps prune re volumes create clean logs reboot

NAME = inception

COMPOSE = docker compose

all: up

up:
	$(COMPOSE) up --build

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v

fclean:
	$(COMPOSE) down -v --rmi all

re: fclean up

.PHONY: all up down clean fclean re
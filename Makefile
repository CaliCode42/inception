NAME = inception

COMPOSE = docker compose
DATA_DIR = /home/tcali/data

all: up

prepare:
	mkdir -p $(DATA_DIR)/mariadb
	mkdir -p $(DATA_DIR)/wordpress

up: prepare
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v

fclean:
	$(COMPOSE) down -v --rmi all
	sudo rm -rf $(DATA_DIR)

re: fclean up

.PHONY: all up down clean fclean re
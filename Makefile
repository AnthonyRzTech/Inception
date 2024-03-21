all: setup_dirs launch_containers

setup_dirs:
	@{ \
	if [ -d "/home/anthrodr/data" ]; then \
		echo "Checking: /home/anthrodr/data exists."; \
	else \
		sudo mkdir /home/anthrodr/data; \
		echo "Action: Created /home/anthrodr/data directory."; \
	fi; \
	if [ -d "/home/anthrodr/data/wordpress" ]; then \
		echo "Checking: /home/anthrodr/data/wordpress exists."; \
	else \
		sudo mkdir /home/anthrodr/data/wordpress; \
		echo "Action: Created /home/anthrodr/data/wordpress directory."; \
	fi; \
	if [ -d "/home/anthrodr/data/mariadb" ]; then \
		echo "Checking: /home/anthrodr/data/mariadb exists."; \
	else \
		sudo mkdir /home/anthrodr/data/mariadb; \
		echo "Action: Created /home/anthrodr/data/mariadb directory."; \
	fi; \
	}

launch_containers:
	@echo "Launching Docker containers..."
	@sudo docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@echo "Taking down Docker containers..."
	@sudo docker compose -f ./srcs/docker-compose.yml down -v

reset: clean_directories

clean_directories:
	@if [ -d "/home/anthrodr/data/wordpress" ]; then \
		sudo rm -rf /home/anthrodr/data/wordpress && \
		echo "Cleaning: Removed /home/anthrodr/data/wordpress/"; \
	fi; \
	if [ -d "/home/anthrodr/data/mariadb" ]; then \
		sudo rm -rf /home/anthrodr/data/mariadb && \
		echo "Cleaning: Removed /home/anthrodr/data/mariadb/"; \
	fi;

fclean: clean_directories prune_docker

prune_docker:
	@echo "Fully cleaning Docker environment..."
	@sudo docker compose -f ./srcs/docker-compose.yml down --rmi all -v
	@sudo docker system prune -a --force

re: fclean all

ls:
	@echo "Listing Docker images and containers..."
	@sudo docker image ls
	@sudo docker ps

.PHONY: all setup_dirs launch_containers down reset clean_directories fclean prune_docker re ls

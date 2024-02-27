# Use Debian Buster as the base image
FROM debian:buster

# Update and upgrade apt packages
RUN apt-get update && apt-get upgrade -y

# Install MariaDB server
RUN apt-get install mariadb-server -y

# Copy configuration files and scripts into the container
COPY conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/Mysql.sh /auto_config.sh

# Define environment variables with default values
ENV SQL_DATABASE=default_db SQL_USER=default_user SQL_PASSWORD=secret SQL_ROOT_PASSWORD=root_secret

# Execute the configuration script on container start
ENTRYPOINT ["bash", "auto_config.sh"]

# Expose the MySQL port
EXPOSE 3306


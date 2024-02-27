#!/bin/bash

# Start MySQL service
service mysql start

# Wait for MySQL to start up
sleep 10

# Use the root password from the environment variable for MySQL commands
export MYSQL_PWD=$SQL_ROOT_PASSWORD

# Create the database if it doesn't exist
mysql -uroot -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Create the user if it doesn't exist, with the specified password
mysql -uroot -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -uroot -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Grant all privileges to the user on the database
mysql -uroot -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'localhost';"
mysql -uroot -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"

# Flush privileges to apply changes
mysql -uroot -e "FLUSH PRIVILEGES;"

# Shutdown MySQL properly
mysqladmin -uroot shutdown

# The `mysqld_safe` command is used to start MySQL with some safety features,
# but it's not suitable for the end of this script as it will keep the script running indefinitely.
# If you need to keep MySQL running in the background, consider removing this line or adjusting your Dockerfile to handle MySQL startup differently.
# exec mysqld_safe

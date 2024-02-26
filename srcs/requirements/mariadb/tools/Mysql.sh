#!/bin/bash

# Démarrer le service MySQL
service mysql start

# Créer la base de données si elle n'existe pas déjà
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Créer l'utilisateur si il n'existe pas déjà, avec le mot de passe spécifié
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

# Donner tous les privilèges à l'utilisateur sur la base de données
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Modifier le mot de passe de l'utilisateur root
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Rafraîchir les privilèges pour prendre en compte les changements
mysql -e "FLUSH PRIVILEGES;"

# Arrêter MySQL proprement
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# Démarrer MySQL sans supervision pour appliquer les changements
exec mysqld_safe

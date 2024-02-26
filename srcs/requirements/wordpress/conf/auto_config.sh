#!/bin/bash

# Attendre que la base de données soit prête
sleep 10

# Configurer WordPress si wp-config.php n'existe pas
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
	wp config create --allow-root \
		--dbname=$SQL_DATABASE \
		--dbuser=$SQL_USER \
		--dbpass=$SQL_PASSWORD \
		--dbhost=mariadb:3306 \
		--path='/var/www/wordpress'

	# Installer WordPress et configurer le premier utilisateur
	wp core install --url="example.com" --title="Example Blog" --admin_user="admin" \
		--admin_password="strongpassword" --admin_email="info@example.com" \
		--path='/var/www/wordpress' --allow-root

	# Ajouter un autre utilisateur (exemple)
	wp user create bob bob@example.com --role=author --user_pass=simplepassword --path='/var/www/wordpress' --allow-root
fi

# Créer le dossier pour PHP-FPM si nécessaire
mkdir -p /run/php

# Démarrer PHP-FPM en arrière-plan
/usr/sbin/php-fpm7.3 -F

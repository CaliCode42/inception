#!/bin/bash

cd /var/www/wordpress

# attendre MariaDB
until mysqladmin ping -h"$MYSQL_HOST" --silent; do
    sleep 10
done

# check if config exists (IMPORTANT)
if [ ! -e wp-config.php ]; then

# créer config propre
	wp config create \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost=mariadb:3306 --path='/var/www/wordpress' \
		--allow-root
fi

# installer WordPress
wp core install \
    --url=$DOMAIN_NAME \
    --title="Inception" \
    --admin_user=$MYSQL_ADMIN \
    --admin_password=$MYSQL_ADMIN_PASSWORD \
    --admin_email=admin@42.fr \
    --skip-email \
    --allow-root

php-fpm7.4 -F
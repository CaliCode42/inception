#!/bin/bash

cd /var/www/wordpress

# attendre MariaDB
until mysqladmin ping -h"$MYSQL_HOST" --silent; do
    sleep 2
done

# supprimer config existante (IMPORTANT)
rm -f wp-config.php

# recréer config propre
wp config create \
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost=$MYSQL_HOST \
    --allow-root

# installer WordPress
wp core install \
    --url=$DOMAIN_NAME \
    --title="Inception" \
    --admin_user=$MYSQL_ADMIN \
    --admin_password=$MYSQL_ADMIN_PASSWORD \
    --admin_email=admin@42.fr \
    --skip-email \
    --allow-root

/usr/sbin/php-fpm7.4 -F
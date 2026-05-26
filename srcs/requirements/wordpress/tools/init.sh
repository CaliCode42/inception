#!/bin/bash
set -e

until mysqladmin ping -h mariadb -u${MYSQL_USER} -p${MYSQL_PASSWORD} --silent; do
  sleep 2
done

echo "DB ready"

if [ ! -f /var/www/wordpress/wp-config.php ]; then
  wp core download --allow-root

  wp config create \
    --dbname=${MYSQL_DATABASE} \
    --dbuser=${MYSQL_USER} \
    --dbpass=${MYSQL_PASSWORD} \
    --dbhost=mariadb \
    --allow-root

  wp core install \
    --url=https://tcali.42.fr \
    --title="Inception" \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --skip-email \
    --allow-root
fi

php-fpm8.2 -F

#!/bin/bash

cd /var/www/wordpress

# config WordPress
cp wp-config-sample.php wp-config.php

sed -i "s/database_name_here/${MYSQL_DATABASE}/" wp-config.php
sed -i "s/username_here/${MYSQL_USER}/" wp-config.php
sed -i "s/password_here/${MYSQL_PASSWORD}/" wp-config.php
sed -i "s/localhost/${MYSQL_HOST}/" wp-config.php

# lancer php-fpm
php-fpm7.4 -F
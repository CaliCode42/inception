#!/bin/bash

# start MariaDB in background
mysqld_safe &

# wait for MariaDB to be ready
until mysqladmin ping -h "localhost" --silent; do
    sleep 1
done

# create database and users (once only)
mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# keep process active
wait
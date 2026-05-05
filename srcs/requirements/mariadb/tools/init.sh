#!/bin/bash

# start MariaDB in background
mysqld_safe &

# wait for MariaDB to be ready
until mysqladmin ping --silent; do
    sleep 1
done

# create database and users (reset first if exist)
mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

mysql -e "DROP USER IF EXISTS '${MYSQL_USER}'@'%';"
mysql -e "DROP USER IF EXISTS '${MYSQL_USER}'@'localhost';"
mysql -e "DROP USER IF EXISTS '${MYSQL_USER}'@'wordpress';"
mysql -e "DROP USER IF EXISTS '${MYSQL_USER}'@'wordpress.git_inception_default';"

mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "CREATE USER '${MYSQL_USER}'@'wordpress' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "CREATE USER '${MYSQL_USER}'@'wordpress.git_inception_default' IDENTIFIED BY '${MYSQL_PASSWORD}';"

mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'wordpress';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'wordpress.git_inception_default';"

mysql -e "FLUSH PRIVILEGES;"

# keep process active
wait
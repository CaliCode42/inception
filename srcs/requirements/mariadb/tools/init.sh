#!/bin/bash

mysqld_safe &

# wait for MariaDB (local)
until mysqladmin ping -h localhost --silent; do
    sleep 2
done

echo "MariaDB is ready"

mysql -u root -h localhost -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

mysql -u root -h localhost -e "DROP USER IF EXISTS '${MYSQL_USER}'@'%';"
mysql -u root -h localhost -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

mysql -u root -h localhost -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mysql -u root -h localhost -e "FLUSH PRIVILEGES;"

echo "Database initialized"

wait
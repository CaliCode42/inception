#!/bin/bash
set -e

echo "Starting MariaDB initialization..."

# Initialiser la base de données si nécessaire
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB database..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql >/dev/null 2>&1
fi

# Démarrer MariaDB en arrière-plan sans authentification pour l'initialisation
mysqld_safe --skip-grant-tables &
MYSQLD_PID=$!

# Attendre que MySQL soit prêt
echo "Waiting for MariaDB to start..."
for i in {1..30}; do
    if mysql -u root -e "SELECT 1;" >/dev/null 2>&1; then
        echo "MariaDB started!"
        break
    fi
    sleep 1
done

# Exécuter les commandes d'initialisation
mysql -u root <<EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';
FLUSH PRIVILEGES;
EOF

# Arrêter et relancer avec authentification
echo "Restarting MariaDB with authentication..."
mysqladmin -u root -p"${MARIADB_ROOT_PASSWORD}" shutdown >/dev/null 2>&1 || true
wait $MYSQLD_PID 2>/dev/null || true
sleep 2

# Démarrer MariaDB normalement
exec mysqld_safe

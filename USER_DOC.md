# USER DOCUMENTATION

## 1. Project overview

This project deploys a small web infrastructure using Docker Compose.

It is composed of three services:

- Nginx: reverse proxy serving HTTPS traffic
- WordPress: PHP-based CMS for the website
- MariaDB: database used by WordPress

All services run in isolated Docker containers connected through a private Docker network.

---

## 2. Services provided

### Nginx
- Acts as a reverse proxy
- Handles HTTPS connections
- Forwards requests to the WordPress service

### WordPress
- Web application (CMS)
- Used to create and manage website content
- Communicates with MariaDB for data storage

### MariaDB
- Database server
- Stores WordPress data (posts, users, settings)

---

## 3. Starting and stopping the project

### Start the project
From the root directory:

```bash
make
````

This will build and start all containers.

Alternatively:

```bash
docker compose up --build
```

---

### Stop the project

```bash
make down
```

or

```bash
docker compose down
```

---

### Full cleanup (including volumes)

```bash
make fclean
```

or

```bash
docker compose down -v
```

---

## 4. Accessing the website

### Website URL

```
https://tcali.42.fr
```

The website is accessible through HTTPS only.

---

### WordPress admin panel

```
https://tcali.42.fr/wp-admin
```

This page allows administration of the WordPress site.

---

## 5. Credentials management

All sensitive credentials are stored in a local `.env` file which is not included in version control.

This file contains:

* Database credentials (user, password, root password)
* WordPress admin credentials
* Domain configuration

Example variables:

* MYSQL_DATABASE
* MYSQL_USER
* MYSQL_PASSWORD
* MARIADB_ROOT_PASSWORD
* WP_ADMIN_USER
* WP_ADMIN_PASSWORD
* WP_ADMIN_EMAIL

---

## 6. Checking if services are running

### Check running containers

```bash
docker ps
```

### Check logs

```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```

### Check network

```bash
docker network inspect inception
```

---

## 7. Data persistence

Data is persisted using Docker volumes mapped to the host machine.

Locations on host:

* /home/tcali/data/mariadb
* /home/tcali/data/wordpress

These directories ensure that data is not lost when containers are stopped or recreated.

---

## 8. Notes

* The project must be started using Docker Compose.
* All services must be running before accessing the website.
* If the website is not reachable, check that all containers are running correctly.


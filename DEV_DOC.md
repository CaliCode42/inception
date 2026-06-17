# DEV DOCUMENTATION

## 1. Purpose

This document explains how to set up, build, run, and maintain the Inception project from a developer perspective.

The project is based on Docker Compose and consists of three services:
- Nginx
- WordPress
- MariaDB

---

## 2. Prerequisites

The following tools must be installed on the host machine:

- Docker Engine
- Docker Compose plugin
- Make (optional but recommended)

To verify installation:

```bash id="1v9x6z"
docker --version
docker compose version
make --version
````

---

## 3. Environment configuration

### 3.1 .env file

The project requires a `.env` file located at the root of the repository.

It contains all sensitive and environment-specific variables such as:

* Database configuration
* WordPress admin credentials
* Domain name configuration

Example:

* MYSQL_DATABASE
* MYSQL_USER
* MYSQL_PASSWORD
* MARIADB_ROOT_PASSWORD
* WP_ADMIN_USER
* WP_ADMIN_PASSWORD
* WP_ADMIN_EMAIL
* DOMAIN_NAME

---

### 3.2 Secrets management

Sensitive data must NOT be committed to version control.

Recommended approach:

* Keep `.env` local and excluded via `.gitignore`
* Optionally use a `secrets/` directory locally for development purposes only

---

## 4. Build and launch the project

### 4.1 Using Makefile (recommended)

```bash id="g8wq0h"
make
```

This command will:

* Build all Docker images
* Create networks and volumes
* Start all services

---

### 4.2 Using Docker Compose directly

```bash id="d3m2ab"
docker compose up --build
```

---

## 5. Container management

### 5.1 Start containers

```bash id="r9k1qp"
docker compose up
```

---

### 5.2 Stop containers

```bash id="k1q9pw"
docker compose down
```

---

### 5.3 Stop and remove volumes

```bash id="p0x8md"
docker compose down -v
```

This will delete persistent database and WordPress data.

---

### 5.4 Rebuild everything from scratch

```bash id="z8c1tw"
docker compose up --build --force-recreate
```

---

### 5.5 View running containers

```bash id="l2q9dn"
docker ps
```

---

### 5.6 View logs

```bash id="x7m3qp"
docker logs nginx
docker logs wordpress
docker logs mariadb
```

---

### 5.7 Access container shell

```bash id="c9p1wx"
docker exec -it mariadb bash
docker exec -it wordpress bash
docker exec -it nginx sh
```

---

## 6. Volumes and data persistence

### 6.1 Storage locations

The project uses bind mounts to persist data on the host machine:

* MariaDB data:
  /home/tcali/data/mariadb

* WordPress files:
  /home/tcali/data/wordpress

---

### 6.2 Purpose of persistence

These volumes ensure:

* Database data is not lost when containers are recreated
* WordPress uploads and configuration persist across restarts

---

### 6.3 Verification

To verify data persistence:

1. Stop containers:

```bash
docker compose down
```

2. Restart containers:

```bash
docker compose up
```

3. Check that WordPress content and database still exist.

---

## 7. Network architecture

All services communicate through a dedicated Docker bridge network:

* Network name: inception

This allows:

* Internal DNS resolution (e.g., `mariadb`, `wordpress`)
* Secure inter-service communication without exposing internal ports

---

## 8. Debugging workflow

Common debugging commands:

### Check service status

```bash id="t5w8qa"
docker ps
```

### Check logs

```bash id="f9m2kx"
docker logs <container>
```

### Inspect network

```bash id="n7q3pw"
docker network inspect inception
```

### Check database

```bash id="b1x9md"
docker exec -it mariadb mariadb -u root -p
```

---

## 9. Notes

* Each service must be fully isolated in its own container
* The project must be reproducible with a single command: `make`
* No manual installation of services should be required on the host machine

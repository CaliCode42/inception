*This project has been created as part of the 42 curriculum by tcali.*

# Inception

## Description

The **Inception** project is an introduction to system administration and DevOps concepts through the use of containerization with Docker.

The goal of this project is to build a small, secure, and modular web infrastructure composed of multiple services running in isolated containers. These services communicate with each other through a Docker network and persist data using volumes.

The infrastructure typically includes:

* A web server using **Nginx** (with HTTPS)
* A database using **MariaDB**
* A CMS using **WordPress**

Each service is built from a custom Docker image and orchestrated using **Docker Compose**.

---

## Instructions

### Requirements

* Docker installed
* Docker Compose enabled (included in Docker Desktop or Docker Engine)

---

### Setup & Run

1. Clone the repository:

```bash
git clone <repository_url>
cd inception
```

2. Build and start the containers:

```bash
docker compose up --build
```

3. Access the website:

```text
https://localhost
```

---

### Stop the project

```bash
docker compose down
```

To remove volumes (deletes database data):

```bash
docker compose down -v
```

---

## Project Architecture

The project is based on a multi-container architecture:

* **Nginx**

  * Reverse proxy
  * Handles HTTPS (SSL/TLS)

* **WordPress**

  * PHP-based CMS
  * Connects to MariaDB

* **MariaDB**

  * Stores website data
  * Uses persistent volumes

All services are connected through a Docker network and communicate using service names.

---

## Technical Choices

### Why Docker?

Docker allows:

* Isolation of services
* Reproducible environments
* Lightweight deployment
* Simplified configuration

---

### Virtual Machines vs Docker

| Virtual Machines     | Docker                   |
| -------------------- | ------------------------ |
| Full OS per instance | Shared kernel            |
| Heavy and slow       | Lightweight and fast     |
| High resource usage  | Efficient resource usage |
| Long startup time    | Instant startup          |

---

### Secrets vs Environment Variables

| Environment Variables | Secrets                    |
| --------------------- | -------------------------- |
| Easy to use           | More secure                |
| Stored in plain text  | Encrypted / protected      |
| Suitable for dev      | Recommended for production |

In this project, environment variables are used for simplicity, but secrets are preferable in real-world deployments.

---

### Docker Network vs Host Network

| Docker Network                          | Host Network        |
| --------------------------------------- | ------------------- |
| Isolated environment                    | Shares host network |
| DNS-based communication (service names) | No isolation        |
| Safer and modular                       | Less secure         |

This project uses Docker networks to ensure proper isolation and communication between services.

---

### Docker Volumes vs Bind Mounts

| Docker Volumes    | Bind Mounts               |
| ----------------- | ------------------------- |
| Managed by Docker | Linked to host filesystem |
| Portable          | System-dependent          |
| Safer and cleaner | More flexible             |

Volumes are used in this project to ensure data persistence and portability.

---

## Resources

### Documentation

* Docker official documentation
* Docker Compose documentation
* Nginx documentation
* MariaDB documentation
* WordPress documentation

---

### Learning Resources

* Docker tutorials (official and community)
* Linux system administration basics
* Networking fundamentals (ports, DNS, HTTP/HTTPS)

---

### AI Usage

AI tools (such as ChatGPT) were used for:

* Understanding Docker concepts (images, containers, volumes, networks)
* Learning Docker Compose structure and best practices
* Debugging configuration issues
* Clarifying system design choices

All configurations and implementations were reviewed, tested, and understood before integration into the project.

---

## Notes

* All services are built using custom Dockerfiles (no prebuilt images allowed except base images)
* Security practices such as HTTPS and environment variable management are applied
* The project focuses on understanding infrastructure rather than just running services

---

# Task Manager - Laravel CRUD App

A simple task management CRUD application built with Laravel 13 and Docker.

## Requirements

- Docker & Docker Compose

## Quick Start

```bash
docker compose up -d
```

The app will be available at **http://localhost:8080**.

## Services

| Service | Container       | Port  |
|---------|-----------------|-------|
| Nginx   | laravel-nginx   | 8080  |
| PHP-FPM | laravel-app     | 9000  |
| MySQL   | laravel-db      | 3307  |

## Features

- Create, read, update, and delete tasks
- Task status tracking (Pending, In Progress, Completed)
- MySQL database with automatic migrations on startup

## Useful Commands

```bash
# View logs
docker compose logs -f

# Run artisan commands
docker compose exec app php artisan <command>

# Stop containers
docker compose down

# Rebuild after changes
docker compose up -d --build
```

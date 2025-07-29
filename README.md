# Library App

This project is divided into two folders:

- **backend/**: Ruby on Rails API (Rails version 8)
- **frontend/**: ReactJS (version 19.1.0)

## Requirements
- Docker and Docker Compose installed
- Ensure these two ports are available 3000 and 8080 

## Authentication & Authorization

- Authentication is handled using JWT tokens, implemented with the
  [devise](https://github.com/heartcombo/devise) gem.
- Authorization is managed with the [cancancan](https://github.com/CanCanCommunity/cancancan)
  gem.

## Preparing data
```bash
docker-compose run api rails db:create
docker-compose run api rails db:migrate
docker-compose run api rails db:seed

```

## How to run
```bash
docker-compose build && docker-compose up
```

The app will be available at http://localhost:8080 (frontend) and
http://localhost:3000 (backend).

## API Documentation

The REST API is documented in the [swagger.yaml](./swagger.yaml) file. You can check it
with Swagger UI https://editor.swagger.io/

## Running tests

To run backend tests:

```bash
docker-compose run api bundle exec rspec
```

## Example users
- Member: gandalf@mail.com / 1234asdf
- Librarian: admin@mail.com / 1234asdf

## Postman Collection

A Postman collection is available for testing the API. You can import the file `Library.postman_collection.json` into Postman to try out all endpoints easily.

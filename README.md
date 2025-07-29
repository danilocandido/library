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

## Instalation
### 1. Clone the Repository
```bash
git clone git@github.com:danilocandido/library.git
cd library

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

## API Documentation (Endpoints)

The REST API is documented in the [swagger.yaml](./swagger.yaml) file. You can check it with Swagger UI https://editor.swagger.io/

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


###  **Authentication and Authorization**

* As a user, I want to **sign up, log in, and log out**
* As a **librarian**, I want to be able to **add, edit**. 
(Deletion is available only in API).
* As a **member**, I should only be able to **view and borrow books** when I search, not edit anything.

###  **Book Management**

* As a librarian, I want to **add a new book** with details like title, author, genre, ISBN, and number of copies.
* As a librarian, I want to **edit existing book details** (Only available in API).
* As a librarian, I want to **delete books from the system** (Only available in API).
* As any user, I want to **search for books by title, author, or genre** so I can find what I need easily.


### **Borrowing and Returning**

* As a member, I want to **borrow a book** if it's available.
* As a member, I should **not be able to borrow the same book more than once at the same time**.
* As the system, I want to **track when a book was borrowed** and **set the due date to 2 weeks later**.
* As a librarian, I want to **mark a book as returned** when the member gives it back.

###  **Dashboard**

* As a librarian, I want a **dashboard that shows total books, total borrowed books, books due today**, and a **list of members with overdue books**.
* As a member, I want a **dashboard that shows the books I've borrowed**, their **due dates**, and **which ones are overdue**.


# Technology Stack

## Technology Stack

### Backend
- **Rails 8.0.2** 
- **Ruby 3.4.5**
- **PostgreSQL**
- **Devise** 
- **Devise-JWT** 
- **Cancancan** 
- **JBuilder**
- **RSpec**

### Frontend (React)
- **React 19.1.0**
- **Vite 7.0.4**

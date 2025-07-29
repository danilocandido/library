# User Story: Library Management System

## Context
As a user of a library system, I want to manage books and borrowings efficiently, with different permissions for librarians and members, so that the library can operate smoothly and users can easily find and borrow books.

## Authentication and Authorization
- Users can register, log in, and log out.
- There are two types of users: Librarian and Member.
- Only Librarian users can add, edit, or delete books.

## Book Management
- Librarians can add a new book with details: title, author, genre, ISBN, and total copies.
- Librarians can edit and delete book details.
- All users can search for a book by title, author, or genre.

## Borrowing and Returning
- Member users can borrow a book if it's available and cannot borrow the same book multiple times.
- The system tracks when a book was borrowed and its due date (2 weeks from borrowing).
- Librarian users can mark a book as returned.

## Dashboard
- Librarian dashboard shows:
  - Total books
  - Total borrowed books
  - Books due today
  - List of members with overdue books
- Member dashboard shows:
  - Books they've borrowed
  - Their due dates
  - Any overdue books

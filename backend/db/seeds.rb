# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Users
gandalf = User.create_with(password: '1234asdf')
  .find_or_create_by(email: 'gandalf@mail.com')
admin = User.create_with(password: '1234asdf')
  .find_or_create_by(email: 'admin@mail.com', role: :librarian)

# Books
silmarillion = Book.find_or_create_by(
  title: 'Silmarilion',
  author: 'Token',
  genre: 'fantasy',
  isbn: '12345ASDFG',
  total_copies: 100
)

clean_code = Book.find_or_create_by(
  title: 'Clean Code',
  author: 'Robert C. Martin',
  genre: 'programming',
  isbn: '9780132350884',
  total_copies: 50
)

the_pragmatic_programmer = Book.find_or_create_by(
  title: 'The Pragmatic Programmer',
  author: 'Andrew Hunt, David Thomas',
  genre: 'programming',
  isbn: '9780201616224',
  total_copies: 40
)

book_design_patterns = Book.find_or_create_by(
  title: 'Design Patterns',
  author: 'Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides',
  genre: 'programming',
  isbn: '9780201633610',
  total_copies: 30
)

book_refactoring = Book.find_or_create_by(
  title: 'Refactoring',
  author: 'Martin Fowler',
  genre: 'programming',
  isbn: '9780201485677',
  total_copies: 25
)

book_introduction_to_algorithms = Book.find_or_create_by(
  title: 'Introduction to Algorithms',
  author: 'Thomas H. Cormen',
  genre: 'algorithms',
  isbn: '9780262033848',
  total_copies: 20
)


[silmarillion, clean_code].each do |book|
  Borrowing.create(
    user: gandalf,
    book: book,
  ).update_columns(
    due_at: 1.day.ago
  )
end

[the_pragmatic_programmer, book_design_patterns].each do |book|
  Borrowing.create(
    user: gandalf,
    book: book,
  )
end

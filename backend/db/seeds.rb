# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Users
User.create_with(password: '1234asdf').find_or_create_by(email: 'gandalf@mail.com')

Book.find_or_create_by(
  title: 'Silmarilion',
  author: 'Token',
  genre: 'fantasy',
  isbn: '12345ASDFG',
  total_copies: 100
)

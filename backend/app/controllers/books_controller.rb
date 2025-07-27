class BooksController < ApplicationController
  load_and_authorize_resource
  before_action :set_book, only: %i[ show update destroy ]

  def index
    @books = Book.accessible_by(current_ability)

    render json: @books
  end

  def show
    render json: @book
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy!
  end

  private

  def set_book
    @book = Book.find(params.expect(:id))
  end

  def book_params
    params.expect(book: %i[title author genre isbn total_copies ])
  end
end

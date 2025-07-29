require 'rails_helper'

RSpec.describe "/books", type: :request do
  include_context 'shared stuff'
  include_context 'device login'

  let(:valid_attributes) {
    {
      title: 'Silmarilion',
      author: 'Token',
      genre: 'fantasy',
      isbn: '12345ASDFG',
      total_copies: 100
    }
  }

  describe "GET /index" do
    before do
      book.save!
      book_hegel.save!
      book_kant.save!
    end

    it "renders a successful response" do
      get books_url, as: :json
      expect(response).to be_successful
      expect(json.size).to eq 3
    end
  end

  describe "GET /search" do
    before do
      book.save!
      book_hegel.save!
    end

    it "retrieve the unique hegel book by title" do
      get search_books_url, params: { q: 'phenomenology' }

      expect(response).to be_successful
      expect(json.size).to eq 1
    end

    it "retrieve the unique hegel book by author" do
      get search_books_url, params: { q: 'hegel' }

      expect(response).to be_successful
      expect(json.size).to eq 1
    end

        it "retrieve the unique hegel book by genre" do
      get search_books_url, params: { q: 'philosophy' }

      expect(response).to be_successful
      expect(json.size).to eq 1
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "renders a JSON response with the new book" do
        post books_url, params: { book: valid_attributes }
        expect(response).to have_http_status(:created)
      end

      it "creates a new Book and new Items" do
        expect {
          post books_url, params: { book: valid_attributes }
        }.to change { Book.count }.by(1)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:book) { Book.create!(valid_attributes) }

    it "deletes the book and returns no content" do
      expect {
        delete book_url(book)
      }.to change { Book.count }.by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end

  describe "PUT /update" do
    let!(:book) { Book.create!(valid_attributes) }

    let(:new_attributes) {
      {
        title: 'Updated Title',
        author: 'Updated Author',
        genre: 'updated genre',
        isbn: 'UPDATEDISBN12',
        total_copies: 50
      }
    }

    it "updates the requested book" do
      put book_url(book), params: { book: new_attributes }
      expect(response).to have_http_status(:ok)
    end
  end
end
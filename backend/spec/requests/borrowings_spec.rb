require 'rails_helper'

RSpec.describe "/borrowings", type: :request do
  include_context 'shared stuff'
  include_context 'device login'

  let(:user) { member }

  let(:valid_attributes) {
    {
      user_id: user.id,
      book_id: book.id
    }
  }

  describe "POST /create" do
    context "member users can borrow a book" do
      it "renders a JSON response with the created borrowing" do
        post borrowings_url, params: { borrowing: valid_attributes }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end

      it "creates a new Book and new Items" do
        expect {
          post borrowings_url, params: { borrowing: valid_attributes }
        }.to change { Borrowing.count }.by(1)
      end
    end

    context "librarian users cannot borrow a book" do
      let(:user) { librarian }

      it "renders a JSON response with the created borrowing" do
        post borrowings_url, params: { borrowing: valid_attributes }

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "patch /return" do
    context "librarian users can return a book" do
      let(:user) { librarian }
      let(:valid_attributes) {
        {
          user_id: member.id,
          book_id: book.id
        }
      }

      it "librarian can return a borrowed book" do
        Borrowing.create!(valid_attributes)

        patch return_borrowings_url, params: { borrowing: valid_attributes }

        expect(response).to have_http_status(:ok)
      end

      it 'prevents returning a book without a prior borrowing record' do
        patch return_borrowings_url, params: { borrowing: valid_attributes }

        expect(response).to have_http_status(:not_found)
      end
    end

    context "librarian users cannot borrow a book" do
      let(:user) { librarian }

      it "renders a JSON response with the created borrowing" do
        post borrowings_url, params: { borrowing: valid_attributes }

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
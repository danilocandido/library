require 'rails_helper'

RSpec.describe "/dashboards", type: :request do
  include_context 'shared stuff'
  include_context 'device login'

  describe "GET /index" do
    

    context 'when user is member' do
      let(:user) { member }

      before do
        [book, book_hegel, book_kant].each do |book|
          Borrowing.create(user: user, book: book)
        end

        # due today
        Borrowing.find_by(book: book).update_columns(due_at: Time.current)
        # overdue
        Borrowing.find_by(book: book_hegel).update_columns(due_at: 1.week.ago)
      end

      it "when there is a book due today " do
        get dashboard_url, as: :json

        expect(response).to be_successful
        expect(json.dig('dashboard', 'books_due_today').size).to eq 1
      end

      it "when there is a book overdue" do
        get dashboard_url, as: :json

        expect(response).to be_successful
        expect(json.dig('dashboard', 'books_overdue').size).to eq 1
      end
    end

    context 'when user is librarian' do
      let(:user) { librarian }
    end

    
  end
end
require 'rails_helper'

RSpec.describe Borrowing, type: :model do
  include_context 'shared stuff'

  subject(:borrowing) do
    Borrowing.new(
      user: user,
      book: book
    )
  end

  let(:user) { member }

  describe 'when some users want to borrow' do
    context 'only members can borrow' do
      it { is_expected.to be_valid }
    end

    context 'librarian cannot borrow' do
      let(:user) { librarian }

      it { is_expected.to be_invalid }
    end
  end

  describe 'when a book was already borrowed by the user' do
    let(:second_borrowing) { borrowing.dup }

    before do
      borrowing.save!
      second_borrowing.save
    end

    it { expect(second_borrowing).to be_invalid }
  end

  describe 'ensure borrowing timestamps exist' do
    before do
      borrowing.save!
    end

    it { expect(borrowing.borrowed_at).to be_present }
    it { expect(borrowing.due_at).to be_present }
  end

  describe 'Users cannot borrow more copies than are available' do
    let(:book) do
      Book.create(
        title: 'Clean Code',
        author: 'Robert C. Martin',
        genre: 'Technology',
        isbn: '12345POIUY',
        total_copies: 1
      )
    end

    let(:member_2) do
      User.create(
        password: '1234asdf',
        email: 'aragorn@mail.com',
        role: :member
      )
    end

    let(:unavailable) { Borrowing.new(user: member_2, book: book) }

    before do
      # This member is borrowing a unique book
      Borrowing.create(user: member, book: book)

      # This another member is trying to borrow the book not available
      unavailable.save
    end

    it { expect(book.total_copies).to eq 1 }
    it { expect(book.borrowings.size).to eq 1 }
    it { expect(unavailable.errors.details).to include(base: [{error: 'Book is not available'}]) }
  end
end

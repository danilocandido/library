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
end

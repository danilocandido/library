require 'rails_helper'

RSpec.describe Book, type: :model do
  subject(:book) do
    Book.new(
      title: 'phenomenology of spirit',
      author: 'Hegel',
      genre: 'philosophy',
      isbn: isbn,
      total_copies: total_copies
    )
  end

  let(:isbn) { '9781566199094' }
  let(:total_copies) { 21 }

  describe 'is valid with valid attributes' do
    it { is_expected.to be_valid }
  end

  describe 'when ISBN is invalid with' do
    subject { book.errors.details }

    let(:errors) { { isbn: error } }

    before do
      book.save
    end

    context 'blank attributes' do
      ['', nil].each do |value|
        let(:isbn) { value }
        let(:error) { [{count: 10, error: :too_short}] }
    
        it { is_expected.to include(errors) }
      end
    end

    context 'smaller than 10 characters' do
      let(:isbn) { '12345' }
      let(:error) { [{count: 10, error: :too_short}] }
  
      it { is_expected.to include(errors) }
    end

    context 'longer than 13 characters' do
      let(:isbn) { '0123456789ABCDEFGH' }
      let(:error) { [{count: 13, error: :too_long}] }
  
      it { is_expected.to include(errors) }
    end
  end

  describe 'when total_copies is invalid with' do
    subject { book.errors.details }

    let(:errors){ { total_copies: error } }

    before do
      book.save
    end

    context 'zero value' do
      let(:total_copies) { 0 }
      let(:error) { [{count: 0, error: :greater_than, value: 0}] }
  
      it { is_expected.to include(errors) }
    end
    
    context 'blank attributes' do
      ['', nil].each do |value|
        let(:total_copies) { value }
        let(:error) { [{error: :not_a_number, value: nil}] }
    
        it { is_expected.to include(errors) }
      end
    end
  end
  
end

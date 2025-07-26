require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.create(email: 'gandalf@mail', password: '1234asdf') }

  describe 'is valid with valid attributes' do
    it { is_expected.to be_valid }
    it { is_expected.to be_member}
  end

  describe 'is not valid without' do
    subject { user.errors.details }

    let(:user) { User.new }
    let(:errors) do
      { 
        email: [{error: :blank}],
        password: [{error: :blank}]
      }
    end

    before do
      user.save
    end

    it { is_expected.to include(errors) }
  end
end

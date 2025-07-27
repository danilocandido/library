RSpec.shared_context "shared stuff" do
  let(:book) do
    Book.new(
      title: 'Silmarilion',
      author: 'Token',
      genre: 'fantasy',
      isbn: '12345ASDFG',
      total_copies: 100
    )
  end

  let(:book_hegel) do
    Book.new(
      title: 'phenomenology of spirit',
      author: 'Hegel',
      genre: 'philosophy',
      isbn: '1112223334445',
      total_copies: 50
    )
  end

  let(:user) do
    User.create_with(
      password: '1234asdf'
    ).find_or_create_by(
      email: 'gandalf@mail.com',
      role: :librarian
    )
  end

  let(:json) { JSON.parse(response.body) }

  before do
    auth_headers(user)
  end

  # sign_in with Devise and JWT
  def auth_headers(user)
    sign_in(user)
    { 'Authorization' => "Bearer #{user.jti}" }
  end
end
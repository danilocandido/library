RSpec.shared_context "shared stuff" do
  let(:book) do
    Book.create(
      title: 'Silmarilion',
      author: 'Token',
      genre: 'fantasy',
      isbn: '12345ASDFG',
      total_copies: 100
    )
  end

  let(:book_hegel) do
    Book.create(
      title: 'phenomenology of spirit',
      author: 'Hegel',
      genre: 'philosophy',
      isbn: '1112223334445',
      total_copies: 50
    )
  end

  let(:book_kant) do
    Book.create(
      title: 'Critique of Pure Reason',
      author: 'Immanual Kant',
      genre: 'philosophy',
      isbn: '9988776655443',
      total_copies: 25
    )
  end

  let(:user) { librarian }
  let(:librarian) do
    User.create_with(
      password: '1234asdf'
    ).find_or_create_by(
      email: 'gandalf@mail.com',
      role: :librarian
    )
  end

  let(:member) do
    User.create_with(
      password: '1234asdf'
    ).find_or_create_by(
      email: 'frodo@mail.com',
      role: :member
    )
  end
end
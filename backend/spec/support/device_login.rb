RSpec.shared_context "device login" do
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
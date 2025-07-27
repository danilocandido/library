class ApplicationController < ActionController::API
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    render json: {
      error: 'Request failed due to insufficient permissions' },
      status: :forbidden
  end

  private

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end

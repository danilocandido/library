Rails.application.routes.draw do
  # Authentication
  devise_for :users, path: 'api', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'api/current_user', to: 'current_user#index'
  
  scope :api do
    resources :books do
      get :search, on: :collection
    end

    resources :borrowings do
      patch :return, on: :collection
    end
  end
end

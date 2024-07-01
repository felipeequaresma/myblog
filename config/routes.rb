Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', skip: %i[omniauth_callbacks registrations sessions passwords token_validations]

  devise_scope :user do
    post 'auth/login', to: 'devise_token_auth/sessions#create'
    delete 'auth/logout', to: 'devise_token_auth/sessions#destroy'
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :posts do
        resources :comments, except: :show
      end

      resources :users
    end
  end
end

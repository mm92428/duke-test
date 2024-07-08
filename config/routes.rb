Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/api/v1/app/status', to: 'application#status'

  # resources :users, path: 'api/v1', only: [:create, :show]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
    end
  end
  post '/api/v1/users/login', to: 'api/v1/users#login'
  post '/api/v1/users/current', to: 'api/v1/users#current'
  
  root to: "application#status"

end

Rails.application.routes.draw do
  root 'welcome#index'

  get 'auth/twitter', to: 'sessions#new', as: :login
  get 'auth/twitter/callback', to: 'sessions#create'

  get '/logout', to: 'sessions#destroy'

  post '/tweet', to: 'tweets#create'
end

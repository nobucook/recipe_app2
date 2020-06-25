Rails.application.routes.draw do
  # get 'ingredients/new'
  # get 'ingredients/create'
  # get 'ingredients/edit'
  # get 'ingredients/update'
  # get 'ingredients/destroy'
  # get 'sessions/new'
  # get 'users/new'
  get root 'static_pages#home'
  get '/about', to:'static_pages#about'
  get '/contact', to:'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/recipes', to: 'recipes#index'
  resources :users
  # resources :account_activations, only: [:edit]
  # resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :recipes
  resources :instructions, only: [:new, :create, :edit, :update, :destroy]
  resources :ingredients, only: [:new, :create, :edit, :update, :destroy]
end

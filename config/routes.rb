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
  post   '/easy_login',   to: 'sessions#easy_login'
  delete '/logout',  to: 'sessions#destroy'
  get '/recipes', to: 'recipes#index'
  resources :users do
    member do
      get :liking
    end
  end
  # resources :account_activations, only: [:edit]
  # resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :recipes do
    member do
      get :likers
    end
  end
  resources :instructions, only: [:new, :create, :edit, :update, :destroy]
  resources :ingredients, only: [:new, :create, :edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]
end

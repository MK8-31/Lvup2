Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'professions/edit'
  get 'lvpros/new'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root 'static_pages#top'
  get  '/contact', to: 'static_pages#contact'
  get  '/news', to: 'static_pages#news'
  get  '/home',    to: 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/top',to: 'static_pages#top'
  get 'lv',to: 'lvpros#new'
  resources :users do
    member do
      get :following, :followers, :likes
    end
  end
  resources :users do
    member do
      get :likes
    end
  end
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :lvpros,              only: [:new,:create, :destroy]
  resources :professions,         only: [:edit,:update]
  resources :likes,               only: [:create, :destroy]
end
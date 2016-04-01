RottenMangoes::Application.routes.draw do

  resources :movies do
    resources :reviews, only: [:new, :create, :destroy]
  end
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'movies#index'
  namespace :admin do
    resources :users
  end

end

Rails.application.routes.draw do
  #devise_for :users - Updated below
  devise_for :users, :controllers => { :registrations => "user/registrations" }
  resources :user_stocks, only: [:create, :destroy]
  resources :users, only: [:show]
  resources :friendships
  
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stocks', to: 'stocks#search'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friends', to: 'users#search'
  
end

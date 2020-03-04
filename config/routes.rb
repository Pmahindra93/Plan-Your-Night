Rails.application.routes.draw do
  devise_for :users
  root to: 'nights#new'
   get 'users/:id', to: 'users#show', as: :user
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :nights, only: [:new, :create, :show] do
    resources :venues, only: [:index, :show]
    resources :night_venues, only: [:create]

  end

  resources :venues, only: [] do
    resources :favourites, only: :create
  end
end

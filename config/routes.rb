Rails.application.routes.draw do
  devise_for :users
  root to: 'nights#new'
   get 'users/:id', to: 'users#show', as: :user
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :nights, only: [:new, :create] do
     resources :venues, only: [:index, :show]

  end
  # edit and only outside everything
  resources :venues do
    resources :favourites, only: :create
       # resources for :venue_reviews inside venues
    resources :venue_reviews, only: :create
  end
  resources :venue_reviews, only: [:edit, :update]

end




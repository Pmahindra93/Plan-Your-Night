Rails.application.routes.draw do

  devise_for :users
  root to: 'nights#new'
  get 'users/:id', to: 'users#show', as: :user
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :nights, only: [:new, :create] do
    resources :venues, only: [:index, :show] do
      collection do
        get 'clubs'
      end
    end
  end

  resources :venues, only: [:show] do
    resources :favourites, only: :create
    resources :venue_reviews, only: :create
  end
  resources :venue_reviews, only: [:edit, :update]

end

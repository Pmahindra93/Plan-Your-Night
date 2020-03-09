Rails.application.routes.draw do

  devise_for :users
  root to: 'nights#new'
  get 'users/:id', to: 'users#show', as: :user
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :nights, only: [:new, :create, :show] do
    resources :venues, only: [:index, :show] do
      collection do
        get 'clubs'
      end
      resources :nights, only: [:update]
      resources :venue_reviews, only: :create
    end
     member do
      get :night_save
     end
     resources :night_venues, only: [:create]
  end


  resources :venues do
    resources :favourites, only: :create
  end
  resources :venue_reviews, only: [:edit, :update]

end

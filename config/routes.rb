Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :venues, only: [:index,:show] do
    get :clubs, on: :collection
    resources :favourites, only: :create
  end
  get '/search', to: 'venues#search', as: :custom_search
  get 'users/:id', to: 'users#show', as: :user
end

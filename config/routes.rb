Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :recipes, only: [:index, :show, :new, :create, :edit, :update]
  resources :recipe_types, only: [:index, :show, :new, :create]
  resources :lists, only: [:index, :show, :new, :create]

  get 'search', to: 'recipes#search'

  get 'my_recipes', to: 'users#show'
end

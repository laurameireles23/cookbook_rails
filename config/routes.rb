Rails.application.routes.draw do
  root to: 'recipes#index'
  resources :recipes, only: [:index, :show, :new, :create, :edit, :update]
  resources :recipe_types, only: [:index, :show, :new, :create]

  get 'search', to: 'recipes#search'
end

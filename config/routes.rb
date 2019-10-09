Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :recipes, only: [:index, :show, :new, :create, :edit, :update] do
    post 'add_to_list', on: :member
    member do
      post 'approve'
      post 'reject'
    end
  end
  resources :recipe_types, only: [:index, :show, :new, :create]
  resources :lists, only: [:index, :show, :new, :create]

  get 'search', to: 'recipes#search'

  get 'evaluate_recipes', to: 'recipes#evaluate'

  get 'my_recipes', to: 'users#show'

  namespace 'api' do
    namespace 'v1' do
      resources :recipes, only: %i[index show]
    end
  end

end

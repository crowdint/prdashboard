Prdashboard::Application.routes.draw do

  root to: 'welcome#index'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :pulls,         only: [:index, :update]
      resources :organizations, only: [:index]
      resources :diffs,         only: [:show]
      resources :comments,      only: [:create, :index]

      get '/pulls/:id/mergeable', to: 'pulls#mergeable'
    end
  end

  resources :sessions, only: [:create, :destroy]

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy', as: :signout
  get '/dashboard', to: 'dashboard#index', as: :dashboard
  get '/analytics', to: 'settings#analytics_keys'

end


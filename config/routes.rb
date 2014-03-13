Prdashboard::Application.routes.draw do

  root to: 'welcome#index'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :pulls,         only: [:index]
      resources :organizations, only: [:index]
      resources :diffs,         only: [:show]
    end
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy', as: :signout
  get '/dashboard', to: 'dashboard#index', as: :dashboard

end


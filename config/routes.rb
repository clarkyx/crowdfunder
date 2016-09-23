Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'projects#index'

  resources :sessions, only: [:index, :new, :create, :destroy]
  resources :projects
  resources :users, only: [:new, :create] do
    resources :messages
    resources :projects do
      resources :rewards
    end
    resources :pledges do
      resources :projects, only: [:show]
    end
  end
end

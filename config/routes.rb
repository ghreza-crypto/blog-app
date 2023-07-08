Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end
  resources :users, only: [:index, :show] do
    resources :posts do
      resources :comments, only: [:new, :create,:destroy]
      resources :likes, only: [:new, :create]
    end
  end
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index, :show] do 
        resources :posts, only: [:index, :show, :new, :create, :destroy] do
          resources :comments, only: [:index, :new, :create, :destroy] 
          resources :likes, only: [:index, :create, :destroy]
        end
      end
    end
  end
  root 'users#index'
  get '/users', to: 'users#index'
end

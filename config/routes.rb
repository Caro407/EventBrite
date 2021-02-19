Rails.application.routes.draw do
  devise_for :users

  resources :events do
    resources :pictures, only: [:new, :create]
  end

  resources :users do
    resources :avatars, only: [:new, :create]
  end

  resources :charges

  resources :attendances

  namespace :admin do
    resources :users, :events, :attendances
  end

  root "events#index"
end

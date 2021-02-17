Rails.application.routes.draw do
  devise_for :users

  resources :events

  resources :users

  resources :charges

  root "events#index"
end

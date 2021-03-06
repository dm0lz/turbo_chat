# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  resources :rooms do
    resources :messages
  end
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

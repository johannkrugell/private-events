# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # root "events#index"
  root 'events#index'

  resources :events, only: [:index, :show, :new, :create]
end

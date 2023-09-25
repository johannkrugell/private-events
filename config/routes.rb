# frozen_string_literal: true

Rails.application.routes.draw do
  # root "events#index"
  root "events#index"

  resources :events, only: [:index, :show, :new, :create]
end

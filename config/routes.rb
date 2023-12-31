# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  # root "events#index"
  root 'events#index'

  resources :events, only: %i[index show new create edit update destroy]
  get 'my_events', to: 'events#my_events', as: 'my_events'
  post 'events/:id/attend', to: 'events#attend', as: 'attend_event'
  post 'events/:id/unattend', to: 'events#unattend', as: 'unattend_event'
  get 'attending_events', to: 'events#attending', as: 'attending_events'
end

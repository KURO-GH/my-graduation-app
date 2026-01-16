# frozen_string_literal: true

Rails.application.routes.draw do
devise_for :users
root 'home#index'
resources :study_logs, only: [:index, :new, :create]
end

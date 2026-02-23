# config/routes.rb
# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # トップページ
  root 'home#index'

  # 使い方説明ページ
  get 'home/how_to_use', to: 'home#how_to_use'

  # 学習記録のCRUD
  resources :study_logs, only: %i[index new create edit update destroy]
end

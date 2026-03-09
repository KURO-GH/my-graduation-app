# config/routes.rb
# frozen_string_literal: true

Rails.application.routes.draw do
  # Deviseの設定
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # プライバシーポリシー
  get 'privacy_policy', to: 'static_pages#privacy_policy'

  # 利用規約
  get 'terms', to: 'static_pages#terms'

  # トップページ
  root 'home#index'

  # 使い方説明ページ
  get 'home/how_to_use', to: 'home#how_to_use'

  # 学習記録のCRUD
  resources :study_logs, only: %i[index new create edit update destroy]

  # 習慣のCRUD + 振り返りページ + 完了ボタン
  resources :habits do
    collection do
      get :review   # /habits/review で振り返りページ
    end

    member do
      patch :toggle_complete  # 完了ボタン用
    end
  end

  # 通知の既読用ルーティング
  resources :notifications, only: [] do
    member do
      patch :mark_read
    end
  end
end


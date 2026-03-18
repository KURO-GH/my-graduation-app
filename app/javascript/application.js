// app/javascript/application.js

// Rails UJS：button_to の method: :delete / :patch を有効にする
import Rails from "@rails/ujs"
Rails.start()  // ← これで button_to が正しく動作

// Turbo（ページ遷移を高速化）
import "@hotwired/turbo-rails"

// ActiveStorage（必要なら）
import "@rails/activestorage"

// ActionCable チャンネル
import "./channels"

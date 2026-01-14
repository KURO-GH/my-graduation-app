# README
# MyGraduationApp

## 概要
このアプリは、Rails 7 を使ったサンプルアプリケーションです。  
学習用として作成しており、Railsの基本的な環境構築やコントローラ・ビューの動作確認ができる構成になっています。

## 開発環境
- Ruby 3.1.4
- Rails 7.0.10
- PostgreSQL 16
- Bundler 2.x
- OS: WSL2 (Ubuntu 24.04)

## セットアップ手順
1. リポジトリをクローン
```bash
   git clone <リポジトリURL>
   cd my-graduation-app
```

## Bundlerで必要なGemをインストール
```
bundle install
```

## データベースを作成・マイグレーション
```
rails db:create
```
```
rails db:migrate
```

## Railsサーバーを起動
```
rails s
```

## ブラウザで確認
http://127.0.0.1:3000


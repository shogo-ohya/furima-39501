Rails.application.routes.draw do
  devise_for :users

  # ユーザー情報の表示・更新などのルート
  resources :users, only: [:show, :edit, :update]

  # 商品一覧ページへのルーティング
  resources :items

  # ルートURLを商品一覧ページに設定
  root 'items#index'
end

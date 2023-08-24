Rails.application.routes.draw do

  # ユーザー情報の表示・更新などのルート
  resources :users, only: [:edit, :update]

  devise_for :users

  resources :items do
    resources :orders, only:[:new, :index, :create]
  end

  
  # オーダー作成のルーティング

  # ルートURLを商品一覧ページに設定
  root 'items#index'

end

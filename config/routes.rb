Rails.application.routes.draw do

  devise_for :users

  resources :items do
    resources :orders, only:[:new, :index, :create]
  end

  
  # オーダー作成のルーティング

  # ルートURLを商品一覧ページに設定
  root 'items#index'

end

class ItemsController < ApplicationController

  before_action :require_login, only: [:new, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_unless_owner, only: [:edit, :update]
  before_action :move_to_index_sold_out, only: :edit


  


  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
    @categories = Category.all

  end

  def show
  end
  
  def edit
  end
  
  def update

    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def redirect_unless_owner
    if current_user && @item.user_id != current_user.id
      redirect_to root_path
    end
  end
  
  def destroy
    if current_user.id == @item.user_id

      if@item.destroy
        redirect_to root_path, notice: '商品情報が削除されました。'
      else
        render :show
      end
    else
      redirect_to root_path, alert: '削除権限がありません。'

    end
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to root_path, notice: '商品情報が登録されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def set_item
    @item = Item.find(params[:id])

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  private


  def require_login
    unless user_signed_in?
      redirect_to user_session_path, notice: "商品出品をするにはログインが必要です。"
    end
  end

  def item_params
    params.require(:item).permit(:name, :explanation, :price, :condition_id, :prefecture_id, :shopping_fee_id, :shopping_duration_id, :category_id,:image).merge(user_id: current_user.id)
  end

end


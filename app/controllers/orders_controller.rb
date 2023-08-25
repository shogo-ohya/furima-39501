class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index]
  before_action :set_item, only:[:index,:create]
  before_action :set_public_key, only:[:index,:create]
  before_action :move_to_index_if_own_item, only: [:index, :create]
  before_action :redirect_root_path, only: [:index]
  before_action :move_to_index_if_sold_out, only: [:index,:create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_root_path
    redirect_to root_path if @item.order.present?
  end

  def move_to_index_if_sold_out
    if @item.order.present?
      redirect_to root_path
    end
  end

  def move_to_index_if_own_item
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]

    Payjp::Charge.create(
        amount: @item.price,         # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
  end

  def set_public_key
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def order_params
    params.require(:order_address).permit( :postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

end
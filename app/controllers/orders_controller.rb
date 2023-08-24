class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]
  before_action :move_to_index_if_own_item, only: [:index, :new, :create]
  before_action :redirect_root_path, only: [:index]
  before_action :move_to_index_if_sold_out, only: [:index, :new, :create]
  #before_action :set_payjp_api_key, only: [:create,:index]

  def new
    @order_address = OrderAddress.new
  end

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]

    @order_address = OrderAddress.new
    @item = Item.find(params[:item_id])
  end

  def create
    
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @item = Item.find(params[:item_id])
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

  #def set_payjp_api_key

  #end

  def redirect_root_path
    @item = Item.find(params[:item_id])
    redirect_to root_path if @item.order.present?
  end

  def move_to_index_if_sold_out
    item = Item.find(params[:item_id])
    if item.order.present?
      redirect_to root_path
    end
  end

  def move_to_index_if_own_item
    item = Item.find(params[:item_id])
    if current_user.id == item.user_id
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

  def order_params
    params.require(:order_address).permit( :postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

end
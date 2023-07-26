class ItemsController < ApplicationController

  before_action :require_login, only: [:new, :index, :show]


  def index
  end

  def new
    @item = Item.new
    @categories = Category.all

  end

  #def show
    #@item = Item.find(params[:id])
  #end
  
  #def edit
    #@item = Item.find(params[:id])
  #end
  
  #def update
    #@item = Item.find(params[:id])
  
   # if @item.update(item_params)
      #redirect_to @item, notice: '商品情報が更新されました。'
    #else
      #render :edit
    #end
  #end
  
  #def destroy
   # @item = Item.find(params[:id])
    #@item.destroy
  
    #redirect_to items_path, notice: '商品情報が削除されました。'
  #end
  
  
  

  def create
    @item = Item.new(item_params)
   

    if @item.save
      redirect_to root_path, notice: '商品情報が登録されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :price, :user_id, :condition_id, :prefecture_id, :shopping_fee_id, :shopping_duration_id, :category_id,:image)
  end

  #def message_params
    #params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  #end
end


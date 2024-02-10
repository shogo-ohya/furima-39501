require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    # 事前にデータをセットアップ
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    end

    context '購入情報が保存できる場合' do
      it 'すべての情報が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end

      it 'buildingが空でも保存できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '購入情報が保存できない場合' do
      it 'tokenが空だと保存できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("トークンを入力して下さい")
      end

      it 'postal_codeが空だと保存できない' do
        @order_address.postal_code = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号を入力して下さい")
      end

      it 'postal_codeが不正な形式だと保存できない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号の形式が正しくありません (e.g. 123-4567)")
      end

      it 'prefecture_idが空だと保存できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("都道府県を入力して下さい")
      end

      it 'cityが空だと保存できない' do
        @order_address.city = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市区町村を入力して下さい")
      end

      it 'addressが空だと保存できない' do
        @order_address.address = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("番地を入力して下さい")
      end

      it 'phone_numberが空だと保存できない' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力して下さい")
      end

      it 'phone_numberが不正な形式だと保存できない' do
        @order_address.phone_number = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号の形式形式が正しくありません")
      end

      it 'phone_numberが9桁以下だと保存できない' do
        @order_address.phone_number = '090123456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号が短すぎます")
      end

      it 'phone_numberが12桁以上だと保存できない' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号が長すぎます")
      end

      it 'userが紐付いていなければ購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていなければ購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
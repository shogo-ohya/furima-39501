require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end



  describe "商品の出品" do
    context "商品出品できる場合" do
      it "is valid with valid attributes" do
        expect(@item).to be_valid
      end
    end

    context "商品出品できない場合" do
      it "画像が空では出品できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品画像を入力して下さい")
      end

      it "商品名が入力されていないと出品できない" do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力して下さい")
      end

      it "商品名が40文字を超えると出品できない" do
        @item.name = "a" * 41
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名が長すぎます")
      end

      it "ユーザーが紐付いていないと出品できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end

      it "カテゴリーが選択されていないと出品できない" do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end

      it "商品の状態が選択されていないと出品できない" do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択してください")
      end

      it "配送料の負担の情報が選択されていないと出品できない" do
        @item.shopping_fee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担の情報を選択してください")
      end

      it"発送元の情報が入力されていないと選択ができない" do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end

      it "発送までの日数情報が選択されていないと出品ができない" do
        @item.shopping_duration_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数情報を選択してください")
      end

      it "商品の説明が入力されていないと出品できない" do
        @item.explanation = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it "価格が入力されていないと出品できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end

      it "価格が300未満だと出品できない" do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は300以上の値にしてください")
      end

      it "価格が9,999,999を超えると出品できない" do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は9999999以下の値にしてください")
      end

      it "価格が数値でないと出品できない" do
        @item.price = "abc"
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
      end
    end
  end
end

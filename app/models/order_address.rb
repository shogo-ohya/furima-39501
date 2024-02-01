class OrderAddress
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture_id, :city, :building, :phone_number, :address, :order_id, :item_id, :user_id
  
  with_options presence: true do
    validates :token, presence: { message: "を入力してください" }
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'の形式が正しくありません（例: 123-4567）' }
    validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :city, presence: { message: "を入力してください" }
    validates :address, presence: { message: "を入力してください" }
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'の形式が正しくありません（半角数字のみ入力してください）' }, length: { in: 10..11, too_long: 'が長すぎます', too_short: 'が短すぎます' }
    validates :user_id
    validates :item_id
  end


  def save
    return false unless valid?

    # Orderの情報を保存する
    order = Order.create(user_id: user_id, item_id: item_id)

    # Addressの情報を保存する
    Address.create(
      order_id: order.id,
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building: building,
      phone_number: phone_number
    )

    true
  end

end
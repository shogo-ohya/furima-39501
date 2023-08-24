class OrderAddress
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :prefecture_id, :city, :building, :phone_number, :address, :order_id, :item_id, :user_id
  
  with_options presence: true do
    validates :token, presence: { message: "can't be blank" }
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city, presence: { message: "can't be blank" }
    validates :address, presence: { message: "can't be blank" }
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' }
    validates :phone_number, length: { in: 10..11, too_long: 'is too long', too_short: 'is too short' }
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
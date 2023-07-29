class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  
  validates :image, presence: true

  # 商品名が必須で最大40文字まで許容
  validates :name, presence: { message: "can't be blank" }, length: { maximum: 40 }

  # 商品の説明が必須
  validates :explanation, presence: {message: "can't be blank"}

  # カテゴリーの情報が必須
  validates :category_id, presence: {message: "Category must be selected"}, numericality: { other_than: 0 }

  # 商品の状態の情報が必須
  validates :condition_id, presence: {message: "Condition must be selected"}, numericality: { other_than: 0 }

  # 配送料の負担の情報が必須
  validates :shopping_fee_id, presence: {message: "Shopping fee must be selected"}, numericality: { other_than: 0 }

  # 発送元の地域の情報が必須
  validates :prefecture_id, presence: {message: "Prefecture must be selected"}, numericality: { other_than: 0 }

  # 発送までの日数の情報が必須
  validates :shopping_duration_id, presence: {message: "Shopping duration must be selected"}, numericality: { other_than: 0 }

  # 価格の情報が必須
  validates :price, presence: {message: "can't be blank"}

  # 価格は¥300〜¥9,999,999の間のみ保存可能であること
  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  validate :validate_selected_options

end

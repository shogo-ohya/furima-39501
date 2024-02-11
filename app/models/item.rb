class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :user

  has_one :order

  def sold_out?
    order.present?
  end
  
  validates :image, presence: true

  # 商品名が必須で最大40文字まで許容
  validates :name, presence: { message: "を入力してください" }, length: { maximum: 40 }

  # 商品の説明が必須
  validates :explanation, presence: {message: "を入力してください"}

  # カテゴリーの情報が必須
  validates :category_id, presence: { message: "カテゴリーを選択してください" }, numericality: { other_than: 1 , message: "を選択してください"}

  # 商品の状態の情報が必須
  validates :condition_id, presence: {message: "商品の状態を選択してください"}, numericality: { other_than: 1, message: "を選択してください"}

  # 配送料の負担の情報が必須
  validates :shopping_fee_id, presence: {message: "配送料の負担を選択してください"}, numericality: { other_than: 1, message: "を選択してください"}

  # 発送元の地域の情報が必須
  validates :prefecture_id, presence: {message: "発送元の地域を選択してください"}, numericality: { other_than: 1, message: "を選択してください"}

  # 発送までの日数の情報が必須
  validates :shopping_duration_id, presence: {message: "発送までの日数を選択してください"}, numericality: { other_than: 1, message: "を選択してください"}

  # 価格の情報が必須
  validates :price, presence: {message: "を入力してください"}

  # 価格は¥300〜¥9,999,999の間のみ保存可能であること
  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  #validate :validate_selected_options

end

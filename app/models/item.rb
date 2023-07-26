class Item < ApplicationRecord
  has_one_attached :image
  
  

  validates :image, presence: true



  


  # 商品名が必須で最大40文字まで許容
  validates :name, presence: { message: "can't be blank" }, length: { maximum: 40 }

  # 商品の説明が必須
  validates :explanation, presence: {message: "can't be blank"}

  # カテゴリーの情報が必須
  validates :category_id, presence: {message: "can't be blank"}

  # 商品の状態の情報が必須
  validates :condition_id, presence: {message: "can't be blank"}

  # 配送料の負担の情報が必須
  validates :shopping_fee_id, presence: {message: "can't be blank"}

  # 発送元の地域の情報が必須
  validates :prefecture_id, presence: {message: "can't be blank"}

  # 発送までの日数の情報が必須
  validates :shopping_duration_id, presence: {message: "can't be blank"}

  # 価格の情報が必須
  validates :price, presence: {message: "can't be blank"}

  # 価格は¥300〜¥9,999,999の間のみ保存可能であること
  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  # 価格は半角数値のみ保存可能であること
  validates :price,{ message: "は半角数値で入力してください" }

  validate :validate_selected_options

  def validate_selected_options
    if category_id.nil?
      errors.add(:category_id, "must be selected")
    end

    if condition_id.nil?
      errors.add(:condition_id, "must be selected")
    end

    if shopping_fee_id.nil?
      errors.add(:shopping_fee_id, "must be selected")
    end

    if prefecture_id.nil?
      errors.add(:prefecture_id, "must be selected")
    end

    if shopping_duration_id.nil?
      errors.add(:shopping_duration_id, "must be selected")
    end
  end

  def was_attached?
    self.image.attached?
  end
end

class Article < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category_id
  belongs_to :condition_id
  belongs_to :prefecture_id
  belongs_to :shopping_duration_id
  belongs_to :shopping_fee_id

  validates :title, :text, presence: true
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :shopping_duration_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :shopping_fee_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :Prefecture_id, numericality: { other_than: 1 , message: "can't be blank"} 

end
class Item < ApplicationRecord
  belongs_to_active_hash :condition
  has_one_attached :image

end

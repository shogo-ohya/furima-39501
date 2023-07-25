class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :explanation
      t.integer :price
      t.integer :user_id
      t.integer :condition_id
      t.integer :prefecture_id
      t.integer :shopping_fee_id
      t.integer :shopping_duration_id
      t.integer :category_id

      t.timestamps
    end
  end
end

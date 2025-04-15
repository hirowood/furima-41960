class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :price, null: false
      t.text    :description, null: false
      t.integer :delivery_day_id, null: false
      t.integer :free_shopping_id, null: false
      t.integer :genre_id, null: false
      t.integer :product_condition_id, null: false
      t.integer :prefecture_id, null: false
      t.timestamps
    end
  end
end

class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string  :title,              null: false
      t.text    :detail,             null: false
      t.integer :category_id,        null: false
      t.integer :condition_id,       null: false
      t.integer :shipping_fee_id,    null: false
      t.integer :prefecture_id,      null: false
      t.integer :delivery_time_id,   null: false
      t.integer :price,              null: false
      t.integer :user_id,            foreign_key: true 
      t.timestamps
    end
  end
end

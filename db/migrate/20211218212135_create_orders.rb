class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.string :postal_code_item, null: false
      t.integer :prefecture_code_item, null: false
      t.string :address_city_item, null: false
      t.string :address_street_item, null: false
      t.string :address_building_item
      t.string :name_item, null: false
      t.integer :postage, null: false
      t.integer :payment, null: false, default: 0, limit: 1
      t.integer :total_amount, null: false
      t.integer :order_status, null: false, default: 0, limit: 1
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end

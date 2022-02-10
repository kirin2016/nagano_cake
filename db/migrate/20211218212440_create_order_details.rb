class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.integer :order_id, null: false
      t.integer :item_id, null: false
      t.integer :amount, null: false
      t.integer :price_purchase, null: false
      t.integer :create_status, null: false, default: 0, limit: 1
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end

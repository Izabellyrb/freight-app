class CreateServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :service_orders do |t|
      t.string :sender_address
      t.string :sender_name
      t.string :receiver_address
      t.string :receiver_name
      t.string :product_code
      t.integer :product_width
      t.integer :product_height
      t.string :order_code
      t.integer :order_weight
      t.integer :order_distance
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

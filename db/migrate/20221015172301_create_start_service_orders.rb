class CreateStartServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :start_service_orders do |t|
      t.references :transport, null: false, foreign_key: true
      t.references :service_order, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end

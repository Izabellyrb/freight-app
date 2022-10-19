class CreateEndServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :end_service_orders do |t|
      t.string :reason
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end

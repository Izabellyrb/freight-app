class RemoveVehicleFromEndServiceOrder < ActiveRecord::Migration[7.0]
  def change
    remove_reference :end_service_orders, :vehicle, null: false, foreign_key: true
  end
end

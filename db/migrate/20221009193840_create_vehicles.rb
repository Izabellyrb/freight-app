class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :plate
      t.string :make
      t.string :model
      t.integer :year
      t.integer :max_load_capacity
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

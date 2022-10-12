class CreateDistancePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :distance_prices do |t|
      t.integer :min_distance
      t.integer :max_distance
      t.decimal :value_km
      t.references :transport, null: false, foreign_key: true

      t.timestamps
    end
  end
end

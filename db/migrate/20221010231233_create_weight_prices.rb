class CreateWeightPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :weight_prices do |t|
      t.integer :min_weight
      t.integer :max_weight
      t.decimal :value_km
      t.references :transport, null: false, foreign_key: true


      t.timestamps
    end
  end
end

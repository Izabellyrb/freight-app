class AddFunctionToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :function, :integer, default: 0
  end
end

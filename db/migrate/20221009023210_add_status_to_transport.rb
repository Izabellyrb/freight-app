class AddStatusToTransport < ActiveRecord::Migration[7.0]
  def change
    add_column :transports, :status, :integer, default: 0
  end
end

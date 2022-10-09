class Transport < ApplicationRecord
  validates :name, :min_distance, :max_distance, :min_weight, :max_weight, :fee, presence: true 
  validates :name, uniqueness: true

  enum status: { enabled: 0, disabled: 2}
end

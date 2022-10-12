class WeightPrice < ApplicationRecord
  validates :min_weight, :max_weight, :value_km, presence: true 
  validates :min_weight, :max_weight, uniqueness: true

  belongs_to :transport
end

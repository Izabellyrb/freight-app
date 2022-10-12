class DistancePrice < ApplicationRecord
  belongs_to :transport

  validates :min_distance, :max_distance, :value_km, presence: true 
  validates :min_distance, :max_distance, uniqueness: true
end

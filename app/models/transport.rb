class Transport < ApplicationRecord
  validates :name, :min_distance, :max_distance, :min_weight, :max_weight, :fee, presence: true 
  validates :name, uniqueness: true
  has_many :weight_price
  has_many :distance_price
  has_many :deadline
  
  enum status: { enabled: 0, disabled: 2}
end

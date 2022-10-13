class Deadline < ApplicationRecord
  belongs_to :transport
  
  validates :min_distance, :max_distance, :time, presence: true 
  validates :min_distance, :max_distance, :time, uniqueness: true
end

class Vehicle < ApplicationRecord
  validates :plate, :make, :model, :year, :max_load_capacity, :status, presence: true 
  validates :plate, uniqueness: true
  validates :plate, format: {with: /\A[a-zA-Z]{3}[0-9][a-zA-Z][0-9]{2}$\z/}
  validates :year, length: {is: 4}

  
  enum status: { available: 0, operating: 2, maintenance: 4}
  
end

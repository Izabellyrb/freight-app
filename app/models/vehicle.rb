class Vehicle < ApplicationRecord
  validates :plate, :make, :model, :year, :max_load_capacity, :status, presence: true 
  validates :plate, uniqueness: true
  validates :plate, format: {with: /\A[a-zA-Z]{3}[0-9][a-zA-Z][0-9]{2}$\z/, message: "deve seguir o padrão Mercosul (LLLNLNN)"}
  validates :year, length: {is: 4}
  has_many :start_service_order
  has_many :service_order, through: :start_service_order

  enum status: { available: 0, operating: 2, maintenance: 4}
  
end

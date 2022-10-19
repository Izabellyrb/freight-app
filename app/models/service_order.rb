class ServiceOrder < ApplicationRecord
  before_validation :generate_code, on: :create
  validates :sender_address, :sender_name, :receiver_address, :receiver_name, :product_code, :order_weight, :order_distance, presence: true   
  has_many :start_service_order
  has_many :end_service_order
  has_many :vehicle
  
  enum status: { pending: 0, progress: 2, finished: 4}
  private

  def generate_code
    self.order_code = SecureRandom.alphanumeric(15).upcase
  end

end

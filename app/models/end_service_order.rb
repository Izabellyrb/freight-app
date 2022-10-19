class EndServiceOrder < ApplicationRecord
  belongs_to :service_order

  validates :reason, presence: true 
end

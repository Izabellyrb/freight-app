class StartServiceOrder < ApplicationRecord
  belongs_to :transport
  belongs_to :service_order
  belongs_to :vehicle

end

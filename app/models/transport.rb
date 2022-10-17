class Transport < ApplicationRecord
  validates :name, :min_distance, :max_distance, :min_weight, :max_weight, :fee, presence: true 
  validates :name, uniqueness: true
  has_many :weight_prices
  has_many :distance_prices
  has_many :deadlines
  has_many :start_service_order

  
  enum status: { enabled: 0, disabled: 2}
  
  def set_service_order
    @service_order = ServiceOrder.find(params[:service_order_id])
  end

  def weight_price(set_service_order)
    weight_prices.each do |wp|
      if set_service_order.order_weight.between?(wp.min_weight, wp.max_weight) 
        return wp.value_km * set_service_order.order_distance
      end
    end
  end

  def distance_price(set_service_order)
    distance_prices.each do |dp|
      if set_service_order.order_distance.between?(dp.min_distance, dp.max_distance)
        return dp.value_km
      end
    end
  end

  def deadline(set_service_order)
    deadlines.each do |d|
      if set_service_order.order_distance.between?(d.min_distance, d.max_distance)
        return I18n.localize((Time.now + d.time * 3600), format: :short)
      else
        return 'Não há valor cadastrado'
      end
    end
  end

end

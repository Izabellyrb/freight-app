class StartServiceOrder < ApplicationRecord
  belongs_to :transport
  belongs_to :service_order
  belongs_to :vehicle

  def set_service_order
    @service_order = ServiceOrder.find(params[:service_order_id])
  end
  
  def transport_available_for(set_service_order)
    options = []
    @transports.each do |t| 
      if set_service_order.order_weight.between?(t.min_weight, t.max_weight) && set_service_order.order_distance.between?(t.min_distance, t.max_distance)
        options << t
      end
    end
    return options
  end

  def fee 
    @transports = Transport.all
    @transport = transport_available_for(service_order)
    @transport.each do |t|
      return t.fee
    end
  end

end

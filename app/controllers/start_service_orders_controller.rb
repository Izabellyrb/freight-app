class StartServiceOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service_order, only: [:new, :create]

  def new
    @start_service_order = StartServiceOrder.new()
    @transports = Transport.all
    @transport = transport_available_for(set_service_order)
    @vehicle = Vehicle.where(status: :available)
  end
  
  def create
    @start_service_order = StartServiceOrder.new(start_service_order_params) 
    @start_service_order.service_order = @service_order
    if @start_service_order.save()
      flash[:notice] = 'OS iniciada com sucesso!'
      @service_order.progress!
      @start_service_order.vehicle.operating!
      redirect_to service_order_url(@service_order.id)
    else
      flash[:notice] = 'OS não iniciada'
      render 'new'
    end
  end
  

  private

  def transport_available_for(set_service_order)
    options = []
    @transports.where(status: :enabled).each do |t| 
      if @service_order.order_weight.between?(t.min_weight, t.max_weight) && @service_order.order_distance.between?(t.min_distance, t.max_distance)
        options << t
      end
    end
    return options 
  end

  def set_service_order
    @service_order = ServiceOrder.find(params[:service_order_id])
  end

  def start_service_order_params
    params.require(:start_service_order).permit(:transport_id, :vehicle_id, :service_order_id) 
  end
end

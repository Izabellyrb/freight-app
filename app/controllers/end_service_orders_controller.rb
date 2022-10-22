class EndServiceOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service_order, only: [:new, :create]

  def new
    @end_service_order = EndServiceOrder.new()
  end

  def create
    @end_service_order = EndServiceOrder.new(end_service_order_params)
    @end_service_order.service_order = @service_order
    if @end_service_order.save()
    flash[:notice] = 'OS finalizada em atraso.'
    @service_order.finished!
    redirect_to service_order_url(@service_order.id)
    else
      flash[:notice] = 'OS não finalizada.'
      render 'new'
    end
  end


  private

  def set_service_order
    @service_order = ServiceOrder.find(params[:service_order_id])
  end

  def end_service_order_params
    params.require(:end_service_order).permit(:reason, :vehicle_id, :service_order_id) 
  end

end



class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:new, :create, :edit, :update]

  def index
    @service_orders = ServiceOrder.all
  end

  def new
    @service_order = ServiceOrder.new()
  end

  def create
    @service_order = ServiceOrder.new(service_order_params) 
    if @service_order.save()
      flash[:notice] = 'Nova OS cadastrada com sucesso!'
      redirect_to service_orders_url
    else
      flash.now[:notice] = "OS não cadastrada!"
      render 'new'
    end
  end
  
  def show
    @service_order = ServiceOrder.find(params[:id])
  end


  private


  def check_user
    if current_user.admin? == false
      return redirect_to service_orders_url, alert: "Você não pode executar esta função"
    end
  end

  def service_order_params
    params.require(:service_order).permit(:sender_address, :sender_name, :receiver_address, :receiver_name, :product_code, :product_width, :product_height, :order_code, :order_weight, :order_distance) 
  end
end

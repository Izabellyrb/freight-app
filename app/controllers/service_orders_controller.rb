class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :show]

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

  def finished
    @service_order = ServiceOrder.find(params[:id])
    @service_order.finished!
    flash[:notice] = "Os finalizada em dia!"
    redirect_to service_order_url(@service_order)
  end
  
  def search
    @order_code = params["query"]
    if @order_code.empty?
      @order_code = nil
    else
      @service_order = ServiceOrder.find_by(order_code: @order_code)
    end
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

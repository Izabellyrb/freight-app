class WeightPricesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:new, :create, :edit, :update]
  before_action :set_wprice, only: [:edit, :update]
  before_action :set_transport, only: [:new, :create, :edit, :update]


  def index
    @weight_prices = WeightPrice.all
  end

  def new
    @weight_price = WeightPrice.new()
  end

  def create
    @weight_price = WeightPrice.new(wprice_params) 
    @weight_price.transport = @transport
    if @weight_price.save()
      flash[:notice] = 'Novo preço cadastrado com sucesso!'
      redirect_to @transport
    else
      flash.now[:notice] = "Preço não cadastrado!"
      render 'new'
    end
  end

  def edit
  end

  def update
    @transport = Transport.find(params[:transport_id])
    if @weight_price.update(wprice_params) 
      flash[:notice] = 'Preço atualizado com sucesso!'
      redirect_to @transport
    else
      flash.now[:notice] = "Preço não atualizado!"
      render 'edit'
    end
  end


  private

  def check_user
    if current_user.admin? == false
      return redirect_to set_transport, alert: "Você não pode executar esta função."
    end
  end

  def wprice_params
    params.require(:weight_price).permit(:min_weight, :max_weight, :value_km) 
  end

  def set_wprice
    @weight_price = WeightPrice.find(params[:id])
  end

  def set_transport
    @transport = Transport.find(params[:transport_id])
  end

end
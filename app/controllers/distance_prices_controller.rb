class DistancePricesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:new, :create, :edit, :update]
  before_action :set_dprice, only: [:edit, :update]
  before_action :set_transport, only: [:new, :create, :edit, :update]

  def index
    @distance_prices = DistancePrice.all
  end

  def new
    @distance_price = DistancePrice.new()
  end

  def create
    @distance_price = DistancePrice.new(dprice_params) 
    @distance_price.transport = @transport
    if @distance_price.save()
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
    if @distance_price.update(dprice_params) 
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

  def dprice_params
    params.require(:distance_price).permit(:min_distance, :max_distance, :value_km) 
  end

  def set_dprice
    @distance_price = DistancePrice.find(params[:id])
  end

  def set_transport
    @transport = Transport.find(params[:transport_id])
  end
end
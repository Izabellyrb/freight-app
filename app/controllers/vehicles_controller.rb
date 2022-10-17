class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:new, :create, :edit, :update, :available, :maintenance, :operating]
  before_action :set_vehicle, only: [:show, :edit, :update, :available, :maintenance, :operating]
  
  def index
    @vehicles = Vehicle.all
  end

  def show
  end

  def new
    @vehicle = Vehicle.new()
  end

  def create
    @vehicle = Vehicle.new(vehicle_params) 
    if @vehicle.save()
      flash[:notice] = 'Novo veículo cadastrado com sucesso!'
      redirect_to vehicles_url
    else
      flash.now[:notice] = "Veículo não cadastrado!"
      render 'new'
    end
  end

  def edit
    @vehicles = Vehicle.all
  end

  def update
    if @vehicle.update(vehicle_params) 
      redirect_to vehicle_url(@vehicle.id)
      flash[:notice] = 'Veículo atualizado com sucesso!'
    else
      flash.now[:notice] = "Veículo não atualizado!"
      render 'edit'
    end
  end

  def operating
    @vehicle.operating!
    flash[:notice] = "Situação atual do veículo atualizada!"
    redirect_to vehicle_url(@vehicle.id)
  end

  def maintenance
    @vehicle.maintenance!
    flash[:notice] = "Situação atual do veículo atualizada!"
    redirect_to vehicle_url(@vehicle.id)
  end

  def available
    @vehicle.available!
    flash[:notice] = "Situação atual do veículo atualizada!"
    redirect_to vehicle_url(@vehicle.id)
  end

  def search
    @plate = params["query"]
    if @plate.empty?
      @plate = nil
    else
      @vehicles = Vehicle.where("plate LIKE ?","%#{@plate}%")
    end
  end

  private

  def check_user
    if current_user.admin? == false
      return redirect_to vehicles_url, alert: "Você não pode executar esta função."
    end
  end

  def vehicle_params
    params.require(:vehicle).permit(:plate, :make, :model, :year, :max_load_capacity) 
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end
end

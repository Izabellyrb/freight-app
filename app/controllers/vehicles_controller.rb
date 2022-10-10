class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:new, :create, :edit, :update]
  before_action :set_vehicle, only: [:show, :edit, :update]
  
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
  end

  def maintenance
    @vehicle.maintenance!
  end

  def available
    @vehicle.available!
  end

  
  private

  def check_user
    if current_user.admin? == false
      return redirect_to vehicles_url, alert: "Você não tem acesso a esta área"
    end
  end

    def vehicle_params
			params.require(:vehicle).permit(:plate, :make, :model, :year, :max_load_capacity) 
	  end

    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end
end

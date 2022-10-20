class TransportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transport, only: [:show, :edit, :update, :disabled, :enabled]
  before_action :check_user, only: [:new, :create, :edit, :update, :disabled, :enabled]
  
  def index 
    @transports = Transport.all
  end

  def show
  end

  def new
    @transport = Transport.new()
  end

  def create
    @transport = Transport.new(transport_params) 
    if @transport.save()
      flash[:notice] = 'Nova modalidade cadastrada com sucesso!'
      redirect_to transports_url
    else
      flash.now[:notice] = "Modalidade não cadastrada!"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @transport.update(transport_params) 
      redirect_to transport_url(@transport.id)
      flash[:notice] = 'Modalidade atualizada com sucesso!'
    else
      flash.now[:notice] = "Modalidade não atualizada!"
      render 'edit'
    end
  end

  def disabled
    @transport.disabled!
    redirect_to @transport
  end

  def enabled
    @transport.enabled!
    redirect_to @transport
  end
  
  private
    def set_transport
        @transport = Transport.find(params[:id])
    end
    def transport_params
			params.require(:transport).permit(:name, :min_distance, :max_distance, :min_weight, :max_weight, :fee) 
	  end
    def check_user
      if current_user.admin? == false
        return redirect_to transports_url, alert: "Você não pode executar esta função"
      end
    end
end
class DeadlinesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: [:new, :create, :edit, :update]
  before_action :set_dprice, only: [:edit, :update]
  before_action :set_transport, only: [:new, :create, :edit, :update]


  def index
    @deadlines = Deadline.all
  end

  def new
    @deadline = Deadline.new()
  end

  def create
    @deadline = Deadline.new(dprice_params) 
    @deadline.transport = @transport
    if @deadline.save()
      flash[:notice] = 'Novo prazo cadastrado com sucesso!'
      redirect_to @transport
    else
      flash.now[:notice] = "Prazo não cadastrado!"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @deadline.update(dprice_params) 
      flash[:notice] = 'Prazo atualizado com sucesso!'
      redirect_to @transport
    else
      flash.now[:notice] = "Prazo não atualizado!"
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
    params.require(:deadline).permit(:min_distance, :max_distance, :time) 
  end

  def set_dprice
    @deadline = Deadline.find(params[:id])
  end

  def set_transport
    @transport = Transport.find(params[:transport_id])
  end

end
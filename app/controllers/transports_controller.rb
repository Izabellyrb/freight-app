class TransportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transport, only: [:show]
  
  def index 
    @transports = Transport.all
  end

  def show
  end



  private
    def set_transport
        @transport = Transport.find(params[:id])
    end
end
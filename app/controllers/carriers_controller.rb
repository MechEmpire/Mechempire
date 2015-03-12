class CarriersController < ApplicationController
  before_action :set_carrier, only: [:show, :edit, :update, :destroy]
  def index
    @carriers = Carrier.all
  end

  def show
  end

  def edit
  end

  def create
  end

  def edit
  end

  def destroy
  end

  private
    def set_carrier
      @carrier = Carrier.find(params[:id])
    end
end

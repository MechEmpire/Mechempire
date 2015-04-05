class CarriersController < ApplicationController
  before_action :set_carrier, only: [:show, :edit, :update, :destroy]
  before_action :admin_user,  only: [:new, :destroy, :edit, :create]
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

  def new
    @carrier = Carrier.new
  end

  def destroy
  end

  private
    def set_carrier
      @carrier = Carrier.find(params[:id])
    end

    # def admin_user
    #   redirect_to(root_path) unless current_user.admin?
    # end
end

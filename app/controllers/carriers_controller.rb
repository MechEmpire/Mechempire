class CarriersController < ApplicationController
  before_action :set_carrier, only: [:show, :edit, :update, :destroy]
  before_action :admin_user,  only: [:new, :destroy, :edit, :create, :update]
  
  def index
    @carriers = Carrier.all
  end

  def show
  end

  def edit
  end

  def create
    @carrier = Carrier.new(carrier_params)

    respond_to do |format|
      if @carrier.save
        format.html { redirect_to @carrier, notice: 'Carrier was successfully created.' }
        format.json { render :show, status: :created, location: @carrier }
      else
        format.html { render :new }
        format.json { render json: @carrier.errors, status: :unprocessable_entity }
      end
    end
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

    def carrier_params
      params.require(:carrier).permit(:name,
                                   :introduce,
                                   :samplepic,
                                   :iden)
    end
end

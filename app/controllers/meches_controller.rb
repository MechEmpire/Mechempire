class MechesController < ApplicationController
  before_action :set_mech, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:create, :edit, :update, :new]

  def index
    #just display one record per page
    @meches = Mech.page(params[:page]).per(10)
    # @meches = Carrier.all
  end

  def mech_list
    @carriers = Carrier.all
    @weapons = Weapon.all
  end

  def create
    @mech = Mech.new( mech_params )
    @mech.create_at = Time.now
    @mech.user_id = current_user.id

    respond_to do |format|
      if @mech.save && @mech.compile && @mech.get_mech_info
        format.html { redirect_to @mech, notice: '机甲创建成功，快去战斗吧！' }
        format.json { render :show, status: :created, location: @mech }
      else
        format.html { render :new }
        format.json { render json: @mech.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @mech = Mech.new
  end

  def show
    
  end

  def edit
  end

  def destroy
  end

  def update
  end

  private
    def set_mech
      @mech = Mech.find(params[:id])
    end

    def mech_params
      params.require(:mech).permit(:code)
    end

    # def signed_in_user
    #   unless signed_in?
    #     store_location
    #     redirect_to signin_url, notice: "请登录后再进行此操作！"
    #   end
    # end
end

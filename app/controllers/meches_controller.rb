class MechesController < ApplicationController
  before_action :set_mech, only: [:show, :edit, :update, :destroy, :surrender]
  before_action :signed_in_user, only: [:create, :edit, :update, :new]
  before_action :actived_user, only: [:create]

  def index
    @meches = Mech.page(params[:page]).per(10)
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
      if @mech.save
        status, stderr = @mech.compile
        if status == 0 && @mech.get_mech_info
          format.html { redirect_to @mech, notice: '机甲创建成功，快去战斗吧！' }
          format.json { render :show, status: :created, location: @mech }
        else
          flash[:danger] = "代码编译失败，错误信息:" + stderr
          FileUtils.rm_r "public/uploads/#{@mech.class.to_s.underscore}/code/#{@mech.id}"
          @mech.destroy
          format.html { render :new }
          format.json { render json: @mech.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @mech.errors, status: :unprocessable_entity }
      end
    end
  end

  def surrender
    respond_to do |format|
      if @mech.update_attribute("state","SURRENDER") && @mech.user.update_attribute("score", @mech.user.score - 3)
        format.js
      else
        format.js do
          render js: "alert('认怂失败')"
        end
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
      params.require(:mech).permit(:code,:manifesto)
    end
end

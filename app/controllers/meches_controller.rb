class MechesController < ApplicationController
  before_action :set_mech, only: [:show, :edit, :update, :destroy, :stop]
  before_action :signed_in_user, only: [:create, :edit, :update, :new, :destroy]
  before_action :actived_user, only: [:create, :destroy, :update]
  before_action :mech_user, only: [:update, :edit]
  before_action :admin_user, only: [:destroy,:index]
  before_action :locked_user, only: :all

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
    @mech.protect_begin_time = Time.now
    @mech.protect_time = 86400

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

  def stop
    respond_to do |format|
      if @mech.update_attribute("state","STOPING")
        format.js
      else
        format.js do
          render js: "alert('休战失败')"
        end
      end
    end
  end

  def start
    respond_to do |format|
      if @mech.update_attribute("state","SUCCESS")
        format.js
      else
        format.js do
          render js: "alert('开战失败')"
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
    respond_to do |format|
      if @mech.destroy
        FileUtils.rm_r "public/uploads/#{@mech.class.to_s.underscore}/code/#{@mech.id}"
        format.html { redirect_to meches_path, notice: '机甲删除成功!' }
        format.json { head :no_content }
      else
        format.html { redirect_to meches_path, notice: '机甲删除失败!' }
        format.json { head :no_content }
      end
    end
  end

  def update
    respond_to do |format|
      FileUtils.rm_r "public/uploads/#{@mech.class.to_s.underscore}/code/#{@mech.id}/code"
      if @mech.update_attributes(mech_params)
        status, stderr = @mech.compile
        if status == 0 && @mech.get_mech_info
          format.html { redirect_to @mech, notice: '机甲更新成功，快去战斗吧！' }
          format.json { render :show, status: :created, location: @mech }
        else
          flash[:danger] = "代码编译失败，错误信息:" + stderr
          #FileUtils.rm_r "public/uploads/#{@mech.class.to_s.underscore}/code/#{@mech.id}/code"
          format.html { render :new }
          format.json { render json: @mech.errors, status: :unprocessable_entity }
        end
      else
        flash['danger'] = "机甲更新失败"
        format.html { render :edit }
        format.json { render json: @mech.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_mech
      @mech = Mech.find(params[:id])
      if @mech.nil?
        render :file => 'public/404.html'
      end
    end

    def mech_params
      params.require(:mech).permit(:code,:manifesto)
    end
end

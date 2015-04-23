class BattlesController < ApplicationController
  before_action :set_battle, only: [:show, :download, :star, :destroy]
  before_action :actived_user, only: [:create, :destroy]
  before_action :admin_user, except: [:create, :download, :index, :show]
  before_action :signed_in_user, only: [:star, :create, :destroy]

  def index
    @battles = Battle.order("time DESC").page(params[:page]).per(10)
  end

  def new
  end

  def create
    defender = Mech.find(params['defender_id'])
    attacker = Mech.find(params['attacker_id'])
    store_location

    if defender.nil? || attacker.nil?
      respond_to do |format|
        flash[:danger] = "机甲参数错误"
        format.html { redirect_back_or root_path}
        # format.json { render json: @battle.errors, status: :unprocessable_entity }
        return
      end
    end

    if defender.state != "SUCCESS" && attacker.state != "SUCCESS"
      respond_to do |format|
        flash[:danger] = "机甲状态不可战"
        format.html { redirect_back_or root_path}
        # format.json { render json: @battle.errors, status: :unprocessable_entity }
        return
      end
    end

    @battle = Battle.new(:defender_id => defender._id,
                         :attacker_id => attacker._id,
                         :time => Time.now)

    if !@battle.save
      respond_to do |format|
        flash[:danger] = "战斗数据写入失败"
        format.html { redirect_back_or(root_path)}
        format.json { render json: @battle.errors, status: :unprocessable_entity }
        return
      end
    end

    if !@battle.battle
      respond_to do |format|
        flash[:danger] = "战斗程序运行失败"
        format.html { redirect_back_or root_path }
        @battle.destroy
        # format.json { render json: @battle.errors, status: :unprocessable_entity }
        return
      end
    end

    defender.battles << @battle
    attacker.battles << @battle

    defender.user.battles << @battle
    attacker.user.battles << @battle

    respond_to do |format|
      format.html { redirect_to @battle, notice: '战斗成功，观看战斗结果！' }
      format.json { render :show, status: :created, location: @battle }
    end
  end

  def destroy
    @battle.destroy
    respond_to do |format|
      format.html { redirect_to battles_url, notice: '删除用户成功!' }
      format.json { head :no_content }
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def star
    respond_to do |format|
      if !@battle.starers.include?(current_user)
        @battle.starers << current_user
        format.js
      else
        format.js do 
          render js:"alert('点赞失败')"
        end
      end
    end
  end

  def download
    send_file "battle/result/#{@battle._id}.txt", :type => 'application/txt'
  end

  private

    def set_battle
      @battle = Battle.find(params[:id])
      if @battle.nil?
        render :file => 'public/404.html'
      end
    end
    # def battle_params
    #   params.require(:battle).permit(:attacker_id,
    #                                  :defender_id)
    # end
end

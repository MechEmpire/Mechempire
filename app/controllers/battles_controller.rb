class BattlesController < ApplicationController
  before_action :set_battle, only: [:show]

  def index
  end

  def new
  end

  def create
    defender = User.find(params['defender_id'])
    attacker = User.find(params['attacker_id'])

    @battle = Battle.new(:defender => defender, 
                         :attacker => attacker,
                         :time => Time.now)

    respond_to do |format|
      if @battle.save
        format.html { redirect_to @battle, notice: '战斗成功，观看战斗结果！' }
        format.json { render :show, status: :created, location: @battle }
      else
        format.html { render :new }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end

  def show

  end

  private

    def set_battle
       @battle = Battle.find(params[:id])
    end
    # def battle_params
    #   params.require(:battle).permit(:attacker_id,
    #                                  :defender_id)
    # end
end

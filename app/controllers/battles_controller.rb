class BattlesController < ApplicationController
  before_action :set_battle, only: [:show]

  def index
  end

  def new
  end

  def create
    defender = Mech.find(params['defender_id'])
    attacker = Mech.find(params['attacker_id'])
    is_success = true

    if defender.nil? && attacker.nil?
      is_success = false
    end

    if is_success
      @battle = Battle.new(:defender_id => defender._id,
                           :attacker_id => attacker._id,
                           :time => Time.now)
    end
    
    respond_to do |format|
      if is_success && @battle.save
        defender.battles << @battle
        attacker.battles << @battle
        
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

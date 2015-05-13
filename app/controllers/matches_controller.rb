class MatchesController < ApplicationController
  before_action :set_match, only: [:show, 
                                   :edit, 
                                   :update, 
                                   :destroy, 
                                   :apply, 
                                   :addmech, 
                                   :result, 
                                   :video, 
                                   :racecard,
                                   :gen_racecard]

  before_action :admin_user, except: [:show,
                                      :index,
                                      :apply,
                                      :addmech,
                                      :racecard]

  before_action :actived_user, only: [:apply, 
                                      :addmech]
  before_action :locked_user

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.page(params[:page]).per(1)
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
  end

  def result
    
  end

  def video
    @battles = @match.battles.page(params[:page]).per(1)
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  # GET /matches/1/edit
  def edit
  end

  
  def apply
    respond_to do |format|
      if current_user && !@match.users.include?(current_user) && @match.users.push(current_user) && !@match.has_end? && @match.has_start?
        format.js
      else
        format.js  do
          render js: 'alert("报名不成功!")'
        end
      end
    end
  end

  def addmech
    mech = Mech.find(params["mech_id"])
    respond_to do |format|
      if mech && current_user.meches.include?(mech) && @match.users.include?(current_user) && !@match.has_end? && @match.has_start?
        last_mech = @match.meches.find_by(:user => current_user)
        if last_mech
          @match.meches.delete(last_mech)
        end
        @match.meches.push(mech)
        format.js do
          render js: "alert('机甲更新成功')"
        end
      else
        format.js do
          render js: "alert('机甲更新失败!')"
        end
      end
    end
  end

  def gen_racecard
    respond_to do |format|
      if @match.battles.clear && @match.create_racecard
        format.html {render :racecard, notice: '对战表生成成功'}
      else
        flash["danger"] = "对战表生成失败"
        format.html { redirect_to @match }
      end
    end
  end

  def racecard
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)

    respond_to do |format|
      if @match.save
        format.html { redirect_to @match, notice: '比赛创建成功' }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to @match, notice: '更新成功' }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: 'Match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
      if @match.nil?
        render :file => 'public/404.html'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      # params[:match]
      params.require(:match).permit(:name,
                                    :introduce,
                                    :start_time,
                                    :end_time)
    end
end

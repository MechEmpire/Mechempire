class WeaponsController < ApplicationController
  before_action :set_weapon, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:new, :destroy, :edit, :create]
  def index
    @weapons = Weapon.all
  end

  def show
  end

  def edit
  end

  def create
    @weapon = Weapon.new(weapon_params)

    respond_to do |format|
      if @weapon.save
        format.html { redirect_to @weapon, notice: 'Weapon was successfully created.' }
        format.json { render :show, status: :created, location: @weapon }
      else
        format.html { render :new }
        format.json { render json: @weapon.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def destroy
  end

  def new
    @weapon = Weapon.new
  end

  private

    def set_weapon
      @weapon = Weapon.find(params[:id])
    end

    def weapon_params
      params.require(:weapon).permit(:name,
                                   :introduce,
                                   :samplepic,
                                   :iden)
    end

    # def admin_user
    #   redirect_to(root_path) unless current_user.admin?
    # end
end

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

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end

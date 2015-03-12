class WeaponsController < ApplicationController
  before_action :set_weapon, only: [:show, :edit, :update, :destroy]
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

  private

    def set_weapon
      @weapon = Weapon.find(params[:id])
    end
end

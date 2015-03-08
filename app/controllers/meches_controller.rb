class MechesController < ApplicationController
  def index
    #just display one record per page
    @meches = Mech.page(params[:page]).per(1)
  end

  def create
  end

  def new
    # @carriers = Carrier.all
    # @weapons = Weapon.all
    @mech = Mech.new
  end

  def edit
  end

  def destroy
  end

  def update
  end
end

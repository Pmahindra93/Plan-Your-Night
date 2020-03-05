class NightsController < ApplicationController
  def new
    @night = Night.new
  end

  def create
    @night = Night.new(night_params)
    @night.user = current_user
    if @night.save
      redirect_to night_venues_path(@night)
    else
      render :new
    end
  end

  def show
    @user = current_user
    @nights = @user.nights
  end

  private

  def night_params
    params.require(:night).permit(:location, :category, :budget)
  end
end

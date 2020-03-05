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
    @night = Night.find(params[:id])
  end

  def update
    @night = Night.find(params[:night_id])
    @venue = Venue.find(params[:venue_id])
    @night.venues << @venue
    @night.save

    if @venue.venue_type == "bar"
      redirect_to clubs_night_venues_path
    else
      redirect_to night_path(@night)
    end
  end

  private

  def night_params
    params.require(:night).permit(:location, :category, :budget)
  end
end

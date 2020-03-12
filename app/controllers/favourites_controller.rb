class FavouritesController < ApplicationController

  def new
    @favourite = Favourite.new
  end

  def create
    @venue = Venue.find(params[:venue_id])
    @favourite = Favourite.new
    @favourite.venue = @venue
    @favourite.user = current_user
    @night = current_user.nights.last
    if @review.save
      redirect_to night_venue_path(@night, @venue)
    else
      flash[:alert] = "You need to submit a valid review!"
      redirect_to night_venue_path(@night, @venue)
    end
  end
end

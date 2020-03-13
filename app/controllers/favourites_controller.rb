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
    @favourite.save
    redirect_to night_venue_path(@night, @venue)
  end
end

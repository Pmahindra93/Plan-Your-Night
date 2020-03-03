class FavouritesController < ApplicationController
  def create
    @venue = Venue.find(params[:venue_id])
    @favourite = Favourite.new
    @favourite.venue = @venue
    @favourite.user = current_user
    @favourite.save
  end
end

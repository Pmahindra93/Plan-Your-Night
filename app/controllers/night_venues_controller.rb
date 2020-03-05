class NightVenuesController < ApplicationController
  def create
    @venue = Venue.find(params[:night_venue][:venue_id])
    @night = Night.find(params[:night_id])
    @night_venue = NightVenue.new
    @night_venue.venue = @venue
    @night_venue.night = @night
    @night_venue.save!
    redirect_to @night
  end

  def show
  end
end

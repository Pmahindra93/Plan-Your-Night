class VenuesController < ApplicationController
  def index
    @venues = Venue.all
    @bars = @venues[category: bars]
  end
end

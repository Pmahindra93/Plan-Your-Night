class VenuesController < ApplicationController
  def show
    @bars = Venue.where(type: 'bar')
    @clubs = Venue.where(type: 'club')
  end
end

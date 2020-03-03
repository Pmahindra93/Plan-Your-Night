class VenuesController < ApplicationController
  before_action :find_venue, only: :show
  skip_before_action :authenticate_user! , only: :show


  def index
    @venues = Venue.all
    @bars = @venues[category: bars]


  def show; end

  private

  def find_venue
    @venue = Venue.find(params[:id])
  end
end

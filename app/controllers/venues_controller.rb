class VenuesController < ApplicationController
  before_action :find_venue, only: :show
  before_action :search, only: [:index, :clubs]
  skip_before_action :authenticate_user! , only: :show

  def index
    @bars = @venues.select {|venue| venue.venue_type == "bar" }
  end

  def clubs
    @clubs = @venues.select {|venue| venue.venue_type == "club" }
  end

  def search
    @night = Night.find(params[:night_id])
    @location = Venue.near(@night.location, 10)
    @category = @night.category
    @budget = @night.budget
    if (@location != "" && @category == "all" && @budget == '')
      @venues = Venue.all
    elsif (@location != "" && @category == "all" && @budget == 'Broke')
      @venues = Venue.where(price_segment: "€")
    elsif (@location != "" && @category == "all" && @budget == 'Reasonable')
      @venues = Venue.where(price_segment: "€€")
    elsif (@location != "" && @category == "all" && @budget == 'Rich')
      @venues = Venue.where(price_segment: "€€€")
    elsif @location != "" && @category != "" && @budget == "Broke"
      @venues = Venue.where(category: @category, price_segment: "€")
    elsif @location != "" && @category != "" && @budget == "Reasonable"
      @venues = Venue.where(category: @category, price_segment: "€€")
    elsif @location != "" && @category != "" && @budget == "Rich"
      @venues = Venue.where(category: @category, price_segment: "€€€")
    end
  end

  def show
    @favourite = Favourite.new
    @night = Night.find(params[:night_id])
    # @night_venue = NightVenue.new

    @reviews = VenueReview.where(venue_id: @venue)
    @review = VenueReview.new()
  end

  def blank_stars
      5 - @review.rating
  end

  private

  def find_venue
    @venue = Venue.find(params[:id])
  end

end


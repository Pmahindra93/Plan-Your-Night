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
    @venue = Venue.near(@night.location, 10)
    @category = @night.category
    @budget = @night.budget
    if (@category == "all") && (@budget == '')
      @venues = @venue.all
    elsif (@category == "all") && (@budget == 'Broke')
      @venues = @venue.where(price_segment: "€")
    elsif (@category == "all") && (@budget == 'Reasonable')
      @venues = @venue.where(price_segment: "€€")
    elsif (@category == "all") && (@budget == 'Rich')
      @venues = @venue.where(price_segment: "€€€")
    elsif (@category != "") && (@budget == "Broke")
      @venues = @venue.where(category: @category, price_segment: "€")
    elsif (@category != "") && (@budget == "Reasonable")
      @venues = @venue.where(category: @category, price_segment: "€€")
    elsif (@category != "") && (@budget == "Rich")
      @venues = @venue.where(category: @category, price_segment: "€€€")
    end
  end

  def show
    @favourite = Favourite.new
    @night = Night.find(params[:night_id])
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


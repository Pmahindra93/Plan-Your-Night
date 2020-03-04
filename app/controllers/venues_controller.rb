class VenuesController < ApplicationController
  before_action :find_venue, only: :show
  before_action :search, only: [:index, :clubs]
  skip_before_action :authenticate_user! , only: :show



  def index
    @bars = @venues.select {|venue| venue.venue_type == "bar" }
  end

  # def bars

  # end

  def clubs
    @clubs = @venues.select {|venue| venue.venue_type == "club" }
  end

  def search

      @night = Night.find(params[:night_id])
      @location = @night.location
      @category = @night.category
      @budget = @night.budget
      if (@location == "Berlin" && @category == "all" && @budget == '')
        @venues = Venue.all
      elsif (@location == "Berlin" && @category == "all" && @budget == 'Broke')
        @venues = Venue.where(price_segment: "€")
      elsif (@location == "Berlin" && @category == "all" && @budget == 'Reasonable')
        @venues = Venue.where(price_segment: "€€")
      elsif (@location == "Berlin" && @category == "all" && @budget == 'Rich')
        @venues = Venue.where(price_segment: "€€€")
      elsif @location == "Berlin" && @category != "" && @budget == "Broke"
        @venues = Venue.where(category: @category, price_segment: "€")
      elsif @location == "Berlin" && @category != "" && @budget == "Reasonable"
        @venues = Venue.where(category: @category, price_segment: "€€")
      elsif @location == "Berlin" && @category != "" && @budget == "Rich"
        @venues = Venue.where(category: @category, price_segment: "€€€")
      end
  end



  def show
    @favourite = Favourite.new

  end

  private

  def find_venue
    @venue = Venue.find(params[:id])
  end

end

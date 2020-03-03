class VenuesController < ApplicationController
  before_action :find_venue, only: :show
  before_action :search, only: :index
  skip_before_action :authenticate_user! , only: :show



  def index
    @bars = @venues.select {|venue| venue.venue_type == "bar" }
    @clubs = @venues.select {|venue| venue.venue_type == "club" }
  end


  def search
    # query_location = 'location ILIKE ?'
    # query_brand = 'brand ILIKE ?'
    # query_both = 'brand ILIKE ? AND name ILIKE ?'
    unless params[:search].nil?
      location = params[:search][:location]
      category = params[:search][:category]
      budget = params[:search][:budget]

      if (params[:search][:location] == "Berlin" && category == "all" && budget == '')
        @venues = Venue.all
      elsif (params[:search][:location] == "Berlin" && category == "all" && budget == 'Broke')
        @venues = Venue.where(price_segment: "€")
      elsif (params[:search][:location] == "Berlin" && category == "all" && budget == 'Reasonable')
        @venues = Venue.where(price_segment: "€€")
      elsif (params[:search][:location] == "Berlin" && category == "all" && budget == 'Rich')
        @venues = Venue.where(price_segment: "€€€")
      elsif params[:search][:location] == "Berlin" && category != "" && budget == "Broke"
        @venues = Venue.where(category: category, price_segment: "€")
      elsif params[:search][:location] == "Berlin" && category != "" && budget == "Reasonable"
        @venues = Venue.where(category: category, price_segment: "€€")
      elsif params[:search][:location] == "Berlin" && category != "" && budget == "Rich"
        @venues = Venue.where(category: category, price_segment: "€€€")
      end
      end
    end


  def show; end

  private

  def find_venue
    @venue = Venue.find(params[:id])
  end
end

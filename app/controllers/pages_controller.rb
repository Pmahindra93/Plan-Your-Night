class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end
  def search
    # query_location = 'location ILIKE ?'
    # query_brand = 'brand ILIKE ?'
    # query_both = 'brand ILIKE ? AND name ILIKE ?'
    unless params[:search].nil?
      location = params[:search][:location]
      category = params[:search][:category]
      budget = params[:search][:budget]

      if (location != "" && category == "" && budget == "")
        @venues = Venue.all
      elsif location != "" && category == "both" && budget == ""
        @venues = Venue.all
      elsif location != "" && category !== "" && budget == ""
        @venues = Venue.where(params[:category])
    else
      @venues = Venue.all
    end
  end
end



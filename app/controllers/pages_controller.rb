class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end
  def search
    query_name = 'name ILIKE ?'
    query_brand = 'brand ILIKE ?'
    query_both = 'brand ILIKE ? AND name ILIKE ?'
    unless params[:search].nil?
      location = params[:search][:location]
      category = params[:search][:category]
      budget = params[:search][:budget]

      if (params[:search][:location] == "" && name == "" && budget == "")
        @venues = Venue.all
      elsif params[:search][:location] != "" && name == ""
        @listings = Listing.where(query_brand, "%#{brand}%")
      elsif params[:search][:brand] == "" && name != ""
        @listings = Listing.where(query_name, "%#{name}%")
      else
        @listings = Listing.where(query_both, "%#{brand}%", "%#{name}%")
      end
    else
      @listings = Listing.all
    end
  end
end



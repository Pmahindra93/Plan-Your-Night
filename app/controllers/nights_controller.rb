class NightsController < ApplicationController
  before_action :find_night, only: [:show, :night_save]
  before_action :find_user, only: [:show, :night_save, :create]
  after_action :clean_db, only: [:new]
  def new
    @night = Night.new
  end

  def create
    @night = Night.new(night_params)
    @night.user = @user
    if @night.save
      redirect_to night_venues_path(@night)
    else
      render :new
    end
  end

  def show
    @markers = @night.venues.map do |venue|
      {
        lat: venue.latitude,
        lng: venue.longitude,
        infoWindow: "#{venue.name}",
        markerType: "#{venue.venue_type}"
      }
    end
    @night_venues = NightVenue.all
    @night_venues.where(night_id: params[:id]).each do |night_venue|
      spend_venue = night_venue.spend_per_venue
      @night.total_spend += spend_venue
    end
  end

  def night_save
    @user.nights << @night
  end

  def update
    @night = Night.find(params[:night_id])
    @venue = Venue.find(params[:venue_id])
    unless @night.venues.include?(@venue)
      @night.venues << @venue
    end
    @night.save
    if @venue.venue_type == "bar"
      redirect_to clubs_night_venues_path
    else
      redirect_to night_path(@night)
    end
  end

def venue_delete
    @night = Night.find(params[:night_id])
    @venue = Venue.find(params[:venue_id])
    @night.night_venues.where(venue_id: params[:venue_id]).destroy_all
    redirect_to night_path(@night)
  end

  private

  def night_params
    params.require(:night).permit(:location, :category, :budget)
  end

  def find_night
    @night = Night.find(params[:id])
  end

  def find_user
    @user = current_user
  end

  def clean_db
    find_user
    bad_nights = @user.nights.select { |night| night.venues.empty? }
    bad_nights.each { |night| night.destroy }
  end
end

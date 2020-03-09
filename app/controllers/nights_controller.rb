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

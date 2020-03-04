class NightsController < ApplicationController
  # def index
  #   @user = current_user
  #   @nights = @user.nights
  # end

  # def new
  #   @nights = Night.new
  #   @venue = Venue.find(params[:venue_id])
  # end

  # def create
  #   @night = Night.new(night_params)
  #   @user = current_user
  #   @night.user = @user
  #   @venue = Venue.find(params[:venue_id])
  #   @night.venue = @venue
  #   # @night.total_price_segment = @night.days * @night.listing.price if @night.days
  #   if @night.save
  #     redirect_to user_path(@user)
  #   else
  #     render :new
  #   end
  # end


  # private

  # def night_params
  #   params.require(:night).permit(:total_price_segment)
  # end
  def new
    @night = Night.new
  end

  def create
    @night = Night.new(night_params)
    @night.user = current_user
    if @night.save
      redirect_to night_venues_path(@night)
    else
      render :new
    end
  end


  private

  def night_params
    params.require(:night).permit(:location, :category, :budget)
  end
end

class VenueReviewsController < ApplicationController

  # Saber donde va estar nuestro 'new' (new no esta en el controller - venue shows)

  # Hacer el form - Validations en el model de VenuesReview

  # Fetch the params para el content, y el ratig (current_user, venue_id ya vienen)
  # Crear una nueva review (VenueReview.new)
  # A esa review asignarle el current user (.user)
  # venue_id (params)
  # rating vienen del form params[:review]
  # content vienen del form params[:review]


  # hacer el if del happy y sad path
  # if review.save  --> redirect /

#######
  # def new
  #   # we need @restaurant in our `simple_form_for`
  #   @restaurant = Restaurant.find(params[:restaurant_id])
  #   @review = Review.new
  # end

  def create
    @review = VenueReview.new(review_params)
    # we need `restaurant_id` to associate review with corresponding restaurant
    @venue = Venue.find(params[:venue_id])
    @review.venue = @venue
    @review.save
    redirect_to venue_path(@venue)
  end

  private

  def review_params
    params.require(:venue_review).permit(:content)
  end
end

end

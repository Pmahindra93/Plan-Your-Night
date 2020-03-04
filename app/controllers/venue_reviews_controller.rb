class VenueReviewsController < ApplicationController
  # 1. Saber donde va estar nuestro 'new' (new no esta en el controller - venue shows)

  # 2. Hacer el form - Validations en el model de VenuesReview

  # 3. Fetch the params para el content, y el ratig (current_user, venue_id ya vienen)
  # 4. Crear una nueva review (VenueReview.new)
  # 5. A esa review asignarle el current user (.user)
  # 6. venue_id (params)
  # 7. rating vienen del form params[:review]
  # 8. content vienen del form params[:review]


  # 9. hacer el if del happy y sad path
  # if review.save  --> redirect /

#######
  # def new
  #   # we need @restaurant in our `simple_form_for`
  #   @restaurant = Restaurant.find(params[:restaurant_id])
  #   @review = Review.new
  # end

    def new
      @review = VenueReview.new()
    end

    def create

      @venue = Venue.find(params["venue_id"]) ;
      @review = VenueReview.new(review_params)
      @review.venue = @venue
      @review.user = current_user

      if @review.save
        redirect_to venue_path(@venue)
      else
        flash[:alert] = "Something went wrong."
        redirect_to root_path
      end
    end



    private

    def review_params
      params.require(:venue_review).permit(:content, :rating)
    end

  end


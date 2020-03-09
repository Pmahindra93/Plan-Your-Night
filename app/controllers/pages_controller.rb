class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if params[:location]
      respond_to do |format|
        format.js {
          p "------------------------------"
          p "------------------------------"
          latitude = params[:location][:latitude].to_f
          longitude = params[:location][:longitude].to_f
          result = Geocoder.search([latitude, longitude])
          @address = result.first.address
        }
      end

    end
  end

end

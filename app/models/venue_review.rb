class VenueReview < ApplicationRecord
  belongs_to :user
  belongs_to :venue

  # this method is just temporal, it should go to a Controller
  def blank_stars
    5 - rating
  end

end

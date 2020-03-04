class Venue < ApplicationRecord
  has_many_attached :photos
  has_many :venue_reviews, dependent: :destroy
end

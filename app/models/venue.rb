class Venue < ApplicationRecord
  has_many_attached :photos
  has_many :venue_reviews, dependent: :destroy
  has_many :night_venues
  has_many :nights, through: :night_venues
end

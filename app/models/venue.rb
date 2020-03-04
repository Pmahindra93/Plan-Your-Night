class Venue < ApplicationRecord
  has_many_attached :photos
  has_many :nights, :through => :night_venues
end

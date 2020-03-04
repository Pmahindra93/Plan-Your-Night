class Venue < ApplicationRecord
  has_many_attached :photos
<<<<<<< HEAD
  has_many :reviews, dependent: :destroy
=======
  has_many :night_venues
  has_many :nights, :through => :night_venues
>>>>>>> master
end

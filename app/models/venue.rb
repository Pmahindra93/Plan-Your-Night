class Venue < ApplicationRecord
  has_many_attached :photos, dependent: :destroy
  has_many :night_venues, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :nights, through: :night_venues
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end

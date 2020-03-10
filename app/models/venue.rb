class Venue < ApplicationRecord
  has_many_attached :photos, dependent: :destroy
  has_many :night_venues, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :venue_reviews, dependent: :destroy
  has_many :night_venues, dependent: :destroy
  has_many :nights, through: :night_venues, dependent: :destroy
  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?

  def spend
    if price_segment == "€"
      return "Avg.spend: 30€/p"
    elsif price_segment == "€€"
      return "Avg.spend: 50€/p"
    elsif price_segment == "€€€"
      return "Avg.spend: 90€/p"
    end
  end
end

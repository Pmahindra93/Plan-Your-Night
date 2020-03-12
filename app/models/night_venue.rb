class NightVenue < ApplicationRecord
  belongs_to :venue
  belongs_to :night

  def spend_per_venue
   if venue.price_segment == "€"
      spend = 30
    elsif venue.price_segment == "€€"
      spend = 50
    elsif venue.price_segment == "€€€"
      spend = 90
    end
    return spend
  end
end

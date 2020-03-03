class Night < ApplicationRecord
  belongs_to :user
  has_many :night_venues
end

class Night < ApplicationRecord
  belongs_to :night_venue
  belongs_to :user
end

class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :venue
  validates :content, :rating, presence: true
end

class Night < ApplicationRecord
  belongs_to :user
  has_many :night_venues, dependent: :destroy
  has_many :venues, through: :night_venues
  # validates :location, presence: true
  # validates :category, presence: true
  # validates :budget, presence: true
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :favourites, dependent: :destroy
  has_many :nights, dependent: :destroy
  has_many :venue_reviews, dependent: :destroy
  has_many :night_venues , through: :nights
  has_one_attached :photo
end

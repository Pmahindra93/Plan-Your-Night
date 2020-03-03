# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
Venue.delete_all
User.delete_all

solar = Venue.new(
  type: 'bar',
  category: 'retro',
  name: 'solar bar',
  address: 'Stresemannstrasse 76, Berlin',
  longitude: 0.0,
  latitude: 0.0,
  opening_hours: "17:00 – 02:00 O'Clock",
  price_segment: '€€€',
  card_accepted: true,
  description: 'Unser einmaliger Außenfahrstuhl führt aus dem Eingangsbereich im Erdgeschoss direkt ins Restaurant in 70 Meter Höhe im Himmel über Berlin. Ein spektakuläres 270-Grad-Panorama trifft bei uns auf gemütliches und urbanes Design. Von jedem Platz aus beobachtet man den wunderschönen Sonnenuntergang und das nächtliche, bunt strahlende Lichtermeer der Hauptstadt.'
)

solar.user = User.new(email: 'bjarne@hinkels.de', first_name: 'Bjarne', last_name: 'Hinkel')
solar1 = URI.open('https://res.cloudinary.com/bjarnehinkel/image/upload/v1583229290/solar_mdtetd.jpg')
solar2 = URI.open('https://res.cloudinary.com/bjarnehinkel/image/upload/v1583229342/solar2_uasmi8.jpg')
solar.photo.attach(io: solar1, filename: 'solar.jpg', content_type: 'image/jpg')
solar.photo.attach(io: solar2, filename: 'solar1.jpg', content_type: 'image/jpg')
solar.save

matrix = Venue.new(
  type: 'club',
  category: 'modern',
  name: 'matrix',
  address: 'Charlottenstraße 34, Berlin',
  longitude: 0.0,
  latitude: 0.0,
  opening_hours: "20:00 – 06:00 O'Clock",
  price_segment: '€€',
  card_accepted: false,
  description: 'Unser einmaliger Außenfahrstuhl führt aus dem Eingangsbereich im Erdgeschoss direkt ins Restaurant in 70 Meter Höhe im Himmel über Berlin. Ein spektakuläres 270-Grad-Panorama trifft bei uns auf gemütliches und urbanes Design. Von jedem Platz aus beobachtet man den wunderschönen Sonnenuntergang und das nächtliche, bunt strahlende Lichtermeer der Hauptstadt.'
)

solar.user = User.new(email: 'bjarne@hinkels.de', first_name: 'Bjarne', last_name: 'Hinkel')
matrix1 = URI.open('https://res.cloudinary.com/bjarnehinkel/image/upload/v1583229930/matrix1_weg4lx.jpg')
matrix2 = URI.open('https://res.cloudinary.com/bjarnehinkel/image/upload/v1583229933/matrix2_zcsote.jpg')
matrix.photo.attach(io: matrix1, filename: 'matrix1.jpg', content_type: 'image/jpg')
matrix.photo.attach(io: matrix2, filename: 'matrix2.jpg', content_type: 'image/jpg')
matrix.save

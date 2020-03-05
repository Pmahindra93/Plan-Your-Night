puts "start"
require 'open-uri'
require 'json'
Venue.delete_all
User.delete_all
Night.delete_all

location = "Berlin"
client_id = ENV['CLIENT_ID']
client_secret = ENV['CLIENT_SECRET']
v = '20180323'
core = "https://api.foursquare.com/v2/venues/explore?client_id=#{client_id}&client_secret=#{client_secret}&v=#{v}&limit=5&near=#{location}&categoryId="

bar_id = '4bf58dd8d48988d116941735'
bar_url = "#{core}#{bar_id}"

club_id = '4bf58dd8d48988d11f941735'
club_url = "#{core}#{club_id}"

response_bar = open(bar_url).read
bars = JSON.parse(response_bar)

bars["response"]["groups"][0]["items"].each do |item|
  desc_url = open("https://api.foursquare.com/v2/venues/#{item["venue"]["id"]}/tips?client_id=#{client_id}&client_secret=#{client_secret}&v=#{v}").read
  desc = JSON.parse(desc_url)
  hours_url = open("https://api.foursquare.com/v2/venues/#{item["venue"]["id"]}/hours?client_id=#{client_id}&client_secret=#{client_secret}&v=#{v}").read
  hours = JSON.parse(hours_url)
  image_url = open("https://api.foursquare.com/v2/venues/#{item["venue"]["id"]}/photos?client_id=#{client_id}&client_secret=#{client_secret}&v=#{v}").read
  image = JSON.parse(image_url)
  bar = Venue.new(
    venue_type: 'bar',
    category: ['Modern','Retro','Alternative','Adult','High-End','Casual'].sample,
    name: item["venue"]["name"],
    address: "#{item["venue"]["location"]["formattedAddress"][0]}, #{item["venue"]["location"]["formattedAddress"][1]}",
    opening_hours: "#{hours["response"]["hours"]["timeframes"][0]["open"][0]["start"]} - #{hours["response"]["hours"]["timeframes"][0]["open"][0]["end"]}",
    price_segment: ['€', '€€', '€€€'].sample,
    card_accepted: [true, false].sample,
    description: desc["response"]["tips"]["items"][0]["text"]
  )
  prefix = image["response"]["photos"]["items"][0]["prefix"]
  width = image["response"]["photos"]["items"][0]["width"]
  height = image["response"]["photos"]["items"][0]["height"]
  suffix = image["response"]["photos"]["items"][0]["suffix"]
  file = URI.open("#{prefix}#{width}x#{height}#{suffix}")
  bar.photo.attach(io: file, filename: "#{item["venue"]["name"]}.jpg", content_type: 'image/jpg')
  bar.save!
end

response_club = open(club_url).read
clubs = JSON.parse(response_club)

clubs["response"]["groups"][0]["items"].each do |item|
  desc_url = open("https://api.foursquare.com/v2/venues/#{item["venue"]["id"]}/tips?client_id=#{client_id}&client_secret=#{client_secret}&v=#{v}").read
  desc = JSON.parse(desc_url)
  hours_url = open("https://api.foursquare.com/v2/venues/#{item["venue"]["id"]}/hours?client_id=#{client_id}&client_secret=#{client_secret}&v=#{v}").read
  hours = JSON.parse(hours_url)
  image_url = open("https://api.foursquare.com/v2/venues/#{item["venue"]["id"]}/photos?client_id=#{client_id}&client_secret=#{client_secret}&v=#{v}").read
  image = JSON.parse(image_url)
  club = Venue.new(
    venue_type: 'club',
    category: ['Modern','Retro','Alternative','Adult','High-End','Casual'].sample,
    name: item["venue"]["name"],
    address: "#{item["venue"]["location"]["formattedAddress"][0]}, #{item["venue"]["location"]["formattedAddress"][1]}",
    opening_hours: "#{hours["response"]["hours"]["timeframes"][0]["open"][0]["start"]} - #{hours["response"]["hours"]["timeframes"][0]["open"][0]["end"]}",
    price_segment: ['€', '€€', '€€€'].sample,
    card_accepted: [true, false].sample,
    description: desc["response"]["tips"]["items"][0]["text"]
  )
  prefix = image["response"]["photos"]["items"][0]["prefix"]
  width = image["response"]["photos"]["items"][0]["width"]
  height = image["response"]["photos"]["items"][0]["height"]
  suffix = image["response"]["photos"]["items"][0]["suffix"]
  file = URI.open("#{prefix}#{width}x#{height}#{suffix}")
  club.photo.attach(io: file, filename: "#{item["venue"]["name"]}.jpg", content_type: 'image/jpg')
  club.save!
end

puts "finish"

puts "start"
require 'open-uri'
require 'json'
Venue.delete_all
User.delete_all
Night.delete_all

LOCATION = "Berlin"
CLIENT_ID = ENV['CLIENT_ID']
CLIENT_SECRET = ENV['CLIENT_SECRET']
V = '20180323'
core = "https://api.foursquare.com/v2/venues/explore?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&v=#{V}&limit=5&near=#{LOCATION}&categoryId="

bar_id = '4bf58dd8d48988d116941735'
bar_url = "#{core}#{bar_id}"

club_id = '4bf58dd8d48988d11f941735'
club_url = "#{core}#{club_id}"

response_bar = open(bar_url).read
bars = JSON.parse(response_bar)

def price_seg_gen(info)
  price_segment = []
  info["response"]["venue"]["price"]["tier"].times do
    price_segment << "€"
  end
  return price_segment.join
end

bars["response"]["groups"][0]["items"].each do |item|
  info_url = open("https://api.foursquare.com/v2/venues/#{item["venue"]["id"]}?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&v=#{V}").read
  info = JSON.parse(info_url)
  bar = Venue.new(
    venue_type: 'bar',
    category: ['Modern','Retro','Alternative','Adult','High-End','Casual'].sample,
    name: info["response"]["venue"]["name"],
    address: "#{info["response"]["venue"]["location"]["formattedAddress"][0]}, #{info["response"]["venue"]["location"]["formattedAddress"][1]}",
    opening_hours: "#{info["response"]["venue"]["popular"]["timeframes"][0]["open"][0]["renderedTime"]}",
    price_segment: price_seg_gen(info),
    card_accepted: [true, false].sample,
    description: "#{info["response"]["venue"]["tips"]["groups"][0]["items"][0]["text"]}"
  )
  prefix = info["response"]["venue"]["photos"]["groups"]["items"]["prefix"]
  width = info["response"]["venue"]["photos"]["groups"]["items"]["width"]
  height = info["response"]["venue"]["photos"]["groups"]["items"]["height"]
  suffix = info["response"]["venue"]["photos"]["groups"]["items"]["suffix"]
  file = URI.open("#{prefix}#{width}x#{height}#{suffix}")
  bar.photos.attach(io: file, filename: "#{info["response"]["venue"]["name"]}.jpg", content_type: 'image/jpg')
  bar.save!
end

response_club = open(club_url).read
clubs = JSON.parse(response_club)

clubs["response"]["groups"][0]["items"].each do |item|
  info_url = open("https://api.foursquare.com/v2/venues/#{item["venue"]["id"]}?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&v=#{V}").read
  info = JSON.parse(info_url)
  club = Venue.new(
    venue_type: 'club',
    category: ['Modern','Retro','Alternative','Adult','High-End','Casual'].sample,
    name: info["response"]["venue"]["name"],
    address: "#{info["response"]["venue"]["location"]["formattedAddress"][0]}, #{info["response"]["venue"]["location"]["formattedAddress"][1]}",
    opening_hours: "#{info["response"]["venue"]["popular"]["timeframes"][0]["open"][0]["renderedTime"]}",
    price_segment: price_seg_gen(info),
    card_accepted: [true, false].sample,
    description: "#{info["response"]["venue"]["tips"]["groups"][0]["items"][0]["text"]}"
  )
  prefix = info["response"]["venue"]["photos"]["groups"]["items"]["prefix"]
  width = info["response"]["venue"]["photos"]["groups"]["items"]["width"]
  height = info["response"]["venue"]["photos"]["groups"]["items"]["height"]
  suffix = info["response"]["venue"]["photos"]["groups"]["items"]["suffix"]
  file = URI.open("#{prefix}#{width}x#{height}#{suffix}")
  club.photos.attach(io: file, filename: "#{info["response"]["venue"]["name"]}.jpg", content_type: 'image/jpg')
  club.save!
end

puts "finish"

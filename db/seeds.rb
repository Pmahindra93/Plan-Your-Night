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
search_url = "https://de.foursquare.com/explore?mode=url&near=Berlin%2C%20Deutschland&nearGeoId=72057594040878095&q="

bar_id = '4bf58dd8d48988d116941735'
bar_url = "#{core}#{bar_id}"

club_id = '4bf58dd8d48988d11f941735'
club_url = "#{core}#{club_id}"

response_bar = open(bar_url).read
bars = JSON.parse(response_bar)

bars["response"]["groups"][0]["items"].each do |item|
  bar = Venue.new(
    venue_type: 'bar',
    category: ['Modern','Retro','Alternative','Adult','High-End','Casual'].sample,
    name: item["venue"]["name"],
    address: "#{item["venue"]["location"]["formattedAddress"][0]}, #{item["venue"]["location"]["formattedAddress"][1]}",
    opening_hours: '17:00 - 02:00',
    price_segment: ['€', '€€', '€€€'].sample,
    card_accepted: [true, false].sample,
  )
  bar.save!
end

response_club = open(club_url).read
clubs = JSON.parse(response_club)

clubs["response"]["groups"][0]["items"].each do |item|
  club = Venue.new(
    venue_type: 'club',
    category: rand_category = ['Modern','Retro','Alternative','Adult','High-End','Casual'].sample,
    name: item["venue"]["name"],
    address: "#{item["venue"]["location"]["formattedAddress"][0]}, #{item["venue"]["location"]["formattedAddress"][1]}",
    opening_hours: '20:00 - 06:00',
    price_segment: ['€', '€€', '€€€'].sample,
    card_accepted: [true, false].sample,
  )
  club.save!
end

puts "finish"

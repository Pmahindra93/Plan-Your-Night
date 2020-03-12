require 'open-uri'
require 'json'

puts "start"

Venue.destroy_all
User.destroy_all
Night.destroy_all

LOCATION = "Berlin"
CLIENT_ID = ENV['CLIENT_ID']
CLIENT_SECRET = ENV['CLIENT_SECRET']
V = '20180323'
number_of_each = 20
core = "https://api.foursquare.com/v2/venues/explore?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&v=#{V}&limit=#{number_of_each}&near=#{LOCATION}&categoryId="

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

def credit_card_check(info)
  unless info["response"]["venue"]["attributes"]["groups"][1].nil?
    credit_card_eval = info["response"]["venue"]["attributes"]["groups"][1]["items"][0]["displayValue"]
    if credit_card_eval == "Nein"
      return false
    elsif credit_card_eval == "Ja"
      return true
    else
      return [true, false].sample
    end
  else
    return false
  end
end

def club_opening(info)
  unless info["response"]["venue"]["hours"].nil?
    return "#{info["response"]["venue"]["hours"]["timeframes"][0]["open"][0]["renderedTime"]}"
  else
    return ": Not Available"
  end
end

def bar_opening(info)
  unless info["response"]["venue"]["popular"].nil?
    return "#{info["response"]["venue"]["popular"]["timeframes"][0]["open"][0]["renderedTime"]}"
  else
    return ": Not Available"
  end
end

bars["response"]["groups"][0]["items"].each do |item|
  info_url = open("https://api.foursquare.com/v2/venues/#{item["venue"]["id"]}?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&v=#{V}").read
  info = JSON.parse(info_url)
  p info["response"]["venue"]["name"]
  p item["venue"]["id"]
  bar = Venue.new(
    venue_type: 'bar',
    category: ['modern','retro'].sample,
    name: info["response"]["venue"]["name"],
    address: "#{info["response"]["venue"]["location"]["formattedAddress"][0]}, #{info["response"]["venue"]["location"]["formattedAddress"][1]}",
    longitude: info["response"]["venue"]["location"]["lng"],
    latitude: info["response"]["venue"]["location"]["lat"],
    opening_hours: bar_opening(info),
    price_segment: price_seg_gen(info),
    card_accepted: credit_card_check(info)
  )
  prefix = info["response"]["venue"]["photos"]["groups"][0]["items"][0]["prefix"]
  width = info["response"]["venue"]["photos"]["groups"][0]["items"][0]["width"]
  height = info["response"]["venue"]["photos"]["groups"][0]["items"][0]["height"]
  suffix = info["response"]["venue"]["photos"]["groups"][0]["items"][0]["suffix"]
  file = URI.open("#{prefix}#{width}x#{height}#{suffix}")
  bar.photos.attach(io: file, filename: "#{info["response"]["venue"]["name"]}.jpg", content_type: 'image/jpg')
  bar.save!
end

puts 'done with bars'

response_club = open(club_url).read
clubs = JSON.parse(response_club)

clubs["response"]["groups"][0]["items"].each do |item|
  info_url = open("https://api.foursquare.com/v2/venues/#{item["venue"]["id"]}?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&v=#{V}").read
  info = JSON.parse(info_url)
  p info["response"]["venue"]["name"]
  p item["venue"]["id"]
  club = Venue.new(
    venue_type: 'club',
    category: ['modern','retro'].sample,
    name: info["response"]["venue"]["name"],
    address: "#{info["response"]["venue"]["location"]["formattedAddress"][0]}, #{info["response"]["venue"]["location"]["formattedAddress"][1]}",
    longitude: info["response"]["venue"]["location"]["lng"],
    latitude: info["response"]["venue"]["location"]["lat"],
    opening_hours: club_opening(info),
    price_segment: price_seg_gen(info),
    card_accepted: credit_card_check(info)
  )
  if info["response"]["venue"]["photos"]["groups"][0].nil?
    info["response"]["venue"]["listed"]["groups"][0]["items"].each do |list_item|
      unless list_item["photo"].nil?
        prefix = list_item["photo"]["prefix"]
        width = list_item["photo"]["width"]
        height = list_item["photo"]["height"]
        suffix = list_item["photo"]["suffix"]
        file = URI.open("#{prefix}#{width}x#{height}#{suffix}")
        club.photos.attach(io: file, filename: "#{info["response"]["venue"]["name"]}.jpg", content_type: 'image/jpg')
      end
    end
  else
    prefix = info["response"]["venue"]["photos"]["groups"][0]["items"][0]["prefix"]
    width = info["response"]["venue"]["photos"]["groups"][0]["items"][0]["width"]
    height = info["response"]["venue"]["photos"]["groups"][0]["items"][0]["height"]
    suffix = info["response"]["venue"]["photos"]["groups"][0]["items"][0]["suffix"]
    file = URI.open("#{prefix}#{width}x#{height}#{suffix}")
    club.photos.attach(io: file, filename: "#{info["response"]["venue"]["name"]}.jpg", content_type: 'image/jpg')
  end
  club.save!
end


puts "finish"


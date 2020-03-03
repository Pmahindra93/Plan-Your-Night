# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts("Start of the seed")
venue1 = Venue.create(type: "Bar", category: "Cocktail-bar", name: "La Tasca", address: "Checkpoint-Charlie")
venue2 = Venue.create(type: "club", category: "Latino", name: "808", address: "Checkpoint-Charlie")

puts("End of the seed")

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require 'open-uri'

puts "Cleaning database..."
Hotel.destroy_all
Room.destroy_all
Booking.destroy_all


10.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password123',
    password_confirmation: 'password123'
  )
end
puts "10 users created"

10.times do
  Hotel.create!(
    name: Faker::Company.name,
    address: Faker::Address.street_address
  )
end
puts "10 hotels created"

Hotel.all.each do |hotel|
  10.times do
    Room.create!(
      price_per_night: Faker::Commerce.price(range: 50..300),
      capacity: rand(1..5),
      hotel_id: hotel.id
    )
  end
end
puts "10 rooms created"

User.all.each do |user|
  10.times do
    Booking.create!(
      user: user,
      room: Room.all.sample,
      starts_at: Faker::Date.between(from: Date.today, to: 1.year.from_now),
      ends_at: Faker::Date.between(from: Date.today + 1.day, to: 1.year.from_now + 1.day)
    )
  end
end
puts "10 bookings created"

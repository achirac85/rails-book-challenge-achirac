# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require 'open-uri'
# db/seeds.rb


# Deleting all records to avoid duplicates
Booking.delete_all
Room.delete_all
Hotel.delete_all
User.delete_all

# Create Users
5.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password123',
    password_confirmation: 'password123'
  )
end

# Create Hotels
3.times do
  Hotel.create!(
    name: Faker::Company.name,
    address: Faker::Address.full_address
  )
end

# Create Rooms for each Hotel
Hotel.all.each do |hotel|
  rand(5..10).times do
    Room.create!(
      price_per_night: Faker::Commerce.price(range: 50..300),
      capacity: rand(1..5),
      hotel_id: hotel.id
    )
  end
end

# Create Bookings for Rooms and Users
User.all.each do |user|
  Room.all.sample(rand(1..3)).each do |room|
    starts_at = Faker::Date.between(from: Date.today, to: 30.days.from_now)
    ends_at = Faker::Date.between(from: starts_at, to: starts_at + 5.days)

    Booking.create!(
      user: user,
      room: room,
      starts_at: starts_at,
      ends_at: ends_at
    )
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'net/http'
require 'json'
User.destroy_all
puts "Creating User"
# Create 10 users
# Create 10 users with default password "password"

puts "Creating users"

10.times do |i|
  # Generate random Github nickname
  response = Net::HTTP.get_response(URI("https://api.github.com/users?since=#{rand(1..99999)}"))
  user_data = JSON.parse(response.body).first
  github_nickname = user_data["login"]

  # Create user with Github info
  User.create!(
    email: "user#{i+10}@example.com",
    password: "password",
    password_confirmation: "password",
    user_name: github_nickname,
    profile_pic: user_data["avatar_url"],
    github_nickname: github_nickname,
  )
end
# Create 10 users with default password "password" and random senior status

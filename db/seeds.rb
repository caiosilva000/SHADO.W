# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.destroy_all
puts "Creating Users"

# Create 10 users
# Create 10 users with default password "password"
3.times do |i|
  User.create!(
    email: "user#{i+1}@example.com",
    password: "password",
    password_confirmation: "password",
    user_name: "user#{i+1}",
    profile_pic: "https://picsum.photos/200",

  )
end
puts "Creating Seniors"

3.times do |i|
  User.create!(
    email: "user#{i+10}@example.com",
    password: "password",
    password_confirmation: "password",
    user_name: "user#{i+10}",
    profile_pic: "https://picsum.photos/200",
  )
end
# Create 10 users with default password "password" and random senior status

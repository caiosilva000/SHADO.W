# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'net/http'
require 'json'
require 'dotenv-rails'

Dotenv.load
Booking.destroy_all
Availability.destroy_all
User.destroy_all
puts "Creating User"


# TEACHERS
senior_users = ["pbragamiranda", "ENPina90", "jhibbeard89", "Danrod16", "AdamTomczyk", "ajdubovoy", "emmvs", "ClaireDMT", "lisbethpurrucker", "SebiBasti"]
senior_users.each do |username|
  response = Net::HTTP.get_response(URI("https://api.github.com/users/#{username}"))
  user_data = JSON.parse(response.body)
  top_languages = []

  if user_data["public_repos"].present? && user_data["public_repos"] > 0
    response = Net::HTTP.get_response(URI("https://api.github.com/users/#{username}/repos"))
    repos = JSON.parse(response.body)
    languages = repos.map { |repo| repo["language"] }.compact
    top_languages = languages.present? ? languages.uniq.first(5) : []
  end

  User.create!(
    email: "#{username}@example.com",
    password: "password",
    password_confirmation: "password",
    user_name: username,
    profile_pic: user_data["avatar_url"],
    github_nickname: username,
    top_languages: top_languages,
    senior: true
  )
end

# Students
students = [
  "caiosilva000",
  "giuliazeni",
  "JDuub",
  "guyberthol",
  "kikarikiki",
  "Dillontsteele",
  "Martinisthename",
  "Thooba",
  "LukasSchanderl",
  "nilahomar",
  "dnussbaummueller",
  "J3L3NA",
  "MonoZyth",
  "aferl-93",
  "MARYFATAH",
  "brenda-daroz",
  "jandachlauer",
  "AlexiaBerlin",
  "memymilk",
  "a-bayborosha"
]
students.each do |username|
  response = Net::HTTP.get_response(URI("https://api.github.com/users/#{username}"))
  user_data = JSON.parse(response.body)
  top_languages = []

  if user_data["public_repos"] && user_data["public_repos"] > 0
    response = Net::HTTP.get_response(URI("https://api.github.com/users/#{username}/repos"))
    repos = JSON.parse(response.body)
    languages = repos.map { |repo| repo["language"] }.compact
    top_languages = languages.present? ? languages.uniq.first(5) : []
  end


  User.create!(
    email: "#{username}@example.com",
    password: "password",
    password_confirmation: "password",
    user_name: username,
    profile_pic: user_data["avatar_url"],
    github_nickname: username,
    top_languages: top_languages,
    senior: false
  )
end


10.times do |i|
  # Generate random Github nickname
  response = Net::HTTP.get_response(URI("https://api.github.com/users?since=#{rand(1..99999)}"))
  user_data = JSON.parse(response.body).first
  p user_data["login"]
  github_nickname = user_data["login"]

  # Fetch user's Github repos and get top language
  response = Net::HTTP.get_response(URI("https://api.github.com/users/#{github_nickname}/repos"))
  repos = JSON.parse(response.body)
  languages = repos.map { |repo| repo["language"] }.compact
  top_languages = languages.present? ? languages.uniq.first(5) : []
  # p top_languages

  # Create user with Github info
  user = User.create!(
    email: "user#{i + 10}@example.com",
    password: "password",
    password_confirmation: "password",
    user_name: github_nickname,
    profile_pic: user_data["avatar_url"],
    github_nickname: github_nickname,
    top_languages: top_languages
  )

  rand(1..10).times do
    start = rand(5).days.from_now + rand(1..5).hours
    Availability.create!(
      user: user,
      start_date: start,
      end_date: start + rand(1..5).hours
    )
  end
end

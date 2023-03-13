# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'net/http'
require 'json'

Booking.destroy_all
Availability.destroy_all
User.destroy_all
puts "Creating User"

# Create 10 users with default password "password"

puts "Creating users"

10.times do |i|
  # Generate random Github nickname
  response = Net::HTTP.get_response(URI("https://api.github.com/users?since=#{rand(1..99999)}"))
  user_data = JSON.parse(response.body).first
  p user_data
  github_nickname = user_data["login"]

  # Generate random senior status
  senior = [true, false].sample

  # Fetch user's Github repos and get top language
  uri = URI("https://api.github.com/users/#{github_nickname}/repos")
  req = Net::HTTP::Get.new(uri)
  req['Authorization'] = "Bearer #{'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'}"
  req['Accept'] = 'application/vnd.github.mercy-preview+json'
  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(req)
  end

  repos = JSON.parse(response.body)
  languages = repos.map { |repo| repo["language"] }.compact
  languages = repos.map { |repo| repo.language }.compact
  top_languages = languages.present? ? languages.uniq.first(5) : []


  # Create user with Github info
  user = User.create!(
    email: "user#{i+10}@example.com",
    password: "password",
    password_confirmation: "password",
    user_name: github_nickname,
    profile_pic: user_data["avatar_url"],
    github_nickname: github_nickname,
    top_languages: [top_languages].compact
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

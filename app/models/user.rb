class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :availabilities
  has_many :follows_as_follower, class_name: "Follow", foreign_key: :follower_id
  has_many :follows_as_following, class_name: "Follow", foreign_key: :following_id
  has_many :bookings_as_bookee, class_name: "Booking", foreign_key: :bookee_id
  has_many :bookings_as_booker, class_name: "Booking", foreign_key: :booker_id
  has_many :posts
  has_many :chatrooms
  has_many :messages
  has_many :reviews, through: :bookings
  # validates :user_name, presence: true
  # validates :profile_pic, presence: true
  # has_many :contributions
  has_many :bookings_as_booker, class_name: "Booking", foreign_key: :booker_id
  has_many :bookings_as_bookee, class_name: "Booking", foreign_key: :bookee_id
  scope :all_except, -> (user) { where.not(id: user) }
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :omniauthable, omniauth_providers: [:github]
after_create_commit { broadcast_append_to "user was created"}
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    unless user
      user = User.create(
        email: data['email'],
        user_name: data['name'],
        password: Devise.friendly_token[0,20]
      )
    end

    # Get the user's top languages from their GitHub account
    client = Octokit::Client.new(access_token: access_token.credentials.token)
    repos = client.repos(nil, sort: :updated)
    languages = repos.map { |repo| repo.language }.compact
    top_languages = languages.present? ? languages.uniq.first(5) : []
    github_user = client.user data['nickname']

    user.update(
      access_token: access_token.credentials.token,
      github_uid: access_token.uid,
      github_nickname: data['nickname'],
      profile_pic: data['image'],
      top_languages: top_languages, # Update the user's top languages in the database
      senior: github_user.created_at.strftime("%Y").to_i < 2021
    )

    user
  end

  include PgSearch::Model
  pg_search_scope :search_users,
  against: [ :user_name ],
  using: {
    tsearch: { prefix: true }
  }

  def followers
    Follow.where(following_id: id).map(&:follower)
  end
  def following
    Follow.where(follower_id: id).map(&:following)
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :availabilities
  has_many :follows_as_follower, class_name: "Follow", foreign_key: :follower_id
  has_many :follows_as_following, class_name: "Follow", foreign_key: :following_id
  has_many :bookings
  has_many :posts
  has_many :chatrooms
  has_many :messages
  has_many :reviews, through: :bookings
  validates :user_name, presence: true
  validates :profile_pic, presence: true
  has_many :contributions

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :omniauthable, omniauth_providers: [:github]

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

    user.update(
      access_token: access_token.credentials.token,
      github_uid: access_token.uid,
      github_nickname: data['nickname'] # Add this line to store the GitHub nickname in a new variable
    )

    user
  end

  include PgSearch::Model
  pg_search_scope :search_users,
  against: [ :user_name ],
  using: {
    tsearch: { prefix: true }
  }
end

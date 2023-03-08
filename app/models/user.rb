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

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0,20]
      )
    end

    # Fetch the profile picture if available and save it to the user's profile_pic attribute
    if access_token.info.image.present?
      user.update(profile_pic: access_token.info.image)
    end

    user
  end
end

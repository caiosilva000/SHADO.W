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

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

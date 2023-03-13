class Follow < ApplicationRecord
  belongs_to :following, class_name: "User"
  belongs_to :follower, class_name: "User"
  has_many :follows_as_follower, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
has_many :follows_as_following, class_name: "Follow", foreign_key: :following_id, dependent: :destroy

end

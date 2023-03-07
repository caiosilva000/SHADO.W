class Chatroom < ApplicationRecord
  belongs_to :junior, class_name: "User"
  belongs_to :senior, class_name: "User"
  has_many :chatrooms_as_junior, class_name: "Chatroom", foreign_key: :junior_id
  has_many :chatrooms_as_senior, class_name: "Chatroom", foreign_key: :senior_id
end

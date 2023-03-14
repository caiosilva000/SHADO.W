class Booking < ApplicationRecord
  belongs_to :availability
  belongs_to :bookee, class_name: "User"
  belongs_to :booker, class_name: "User"
  validates :start_date, presence: true
  validates :end_date, presence: true
end

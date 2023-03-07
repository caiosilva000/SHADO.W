class Booking < ApplicationRecord
  belongs_to :availability
  belongs_to :bookee, class_name: "User"
  belongs_to :booker, class_name: "User"
end

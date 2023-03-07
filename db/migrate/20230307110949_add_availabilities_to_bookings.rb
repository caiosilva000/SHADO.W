class AddAvailabilitiesToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :availabilities, null: false, foreign_key: true
  end
end

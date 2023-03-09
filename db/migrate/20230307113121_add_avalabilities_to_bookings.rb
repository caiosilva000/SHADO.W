class AddAvalabilitiesToBookings < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :availability, null: false, foreign_key: true
  end
end

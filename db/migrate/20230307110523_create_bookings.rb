class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.integer :price
      t.boolean :status
      t.references  :bookee, null: false, foreign_key: { to_table: :users }
      t.references  :booker, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

  end
end

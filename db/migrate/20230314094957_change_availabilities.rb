class ChangeAvailabilities < ActiveRecord::Migration[7.0]
  def change
    remove_column :availabilities, :monday, :boolean, default: true
    remove_column :availabilities, :tuesday, :boolean, default: true
    remove_column :availabilities, :wednesday, :boolean, default: true
    remove_column :availabilities, :thursday, :boolean, default: true
    remove_column :availabilities, :friday, :boolean, default: true
    remove_column :availabilities, :saturday, :boolean, default: true
    remove_column :availabilities, :sunday, :boolean, default: true
    remove_column :availabilities, :start, :time
    remove_column :availabilities, :end, :time
    remove_column :availabilities, :start_date
    remove_column :availabilities, :end_date
    add_column :availabilities, :start_date, :datetime
    add_column :availabilities, :end_date, :datetime
  end
end

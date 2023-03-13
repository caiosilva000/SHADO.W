class AddSeniorToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :senior, :boolean, default: false
  end
end

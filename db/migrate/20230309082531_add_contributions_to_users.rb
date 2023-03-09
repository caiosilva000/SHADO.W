class AddContributionsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :contributions, :integer
  end
end

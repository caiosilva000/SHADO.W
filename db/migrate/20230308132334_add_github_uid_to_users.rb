class AddGithubUidToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :github_uid, :string
  end
end

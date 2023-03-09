class AddGithubNicknameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :github_nickname, :string
  end
end

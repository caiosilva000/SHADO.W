class AddTopLanguagesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :top_languages, :string, array: true, default: []
  end
end

class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_name, :string
    add_column :users, :profile_pic, :text
    add_column :users, :bio, :text
    add_column :users, :location, :string
    add_column :users, :my_stack, :string
    add_column :users, :senior, :boolean
  end
end

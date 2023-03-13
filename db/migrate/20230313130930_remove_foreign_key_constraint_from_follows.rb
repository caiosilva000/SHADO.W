class RemoveForeignKeyConstraintFromFollows < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :follows, :users, column: :follower_id
    remove_foreign_key :follows, :users, column: :following_id

  end
end

class RemoveBadForeignKeysFromFriends < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :friends, column: :friend_id rescue nil
    remove_foreign_key :friends, column: :user_id rescue nil
  end
end

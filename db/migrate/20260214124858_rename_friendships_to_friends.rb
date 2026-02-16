class RenameFriendshipsToFriends < ActiveRecord::Migration[8.1]
  def change
    rename_table :friendships, :friends
  end
end

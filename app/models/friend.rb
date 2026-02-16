class Friend < ApplicationRecord
  self.table_name = "friends"
  
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :user_id, uniqueness: { scope: :friend_id }
end
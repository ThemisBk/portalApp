class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :posts, dependent: :destroy

  #Requester
  has_many :friendships, class_name: "Friend", dependent: :destroy
  has_many :friends, through: :friendships, source: :friend

  #Reciever
  has_many :inverse_friendships, class_name: "Friend", foreign_key: "friend_id", dependent: :destroy
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def pending_friend_requests
    inverse_friendships.where(status: "pending")
  end

  def friends_list
    friends.where("friends.status = ?", "accepted") + 
    inverse_friends.where("friends.status = ?", "accepted")
  end
end
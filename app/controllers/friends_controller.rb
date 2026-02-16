class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id)
  end

  def add_friend
    @friend_user = User.find(params[:friend_id])
    
    @friend = current_user.friendships.build(friend_id: @friend_user.id, status: "pending")
    
    if @friend.save
      redirect_to users_path, notice: "Friend request sent to #{@friend_user.email}"
    else
      redirect_to users_path, alert: "Could not send friend request"
    end
  end

  def accept
    @friend = Friend.find_by(user_id: params[:id], friend_id: current_user.id)
    if @friend.update(status: "accepted")
      redirect_to users_path, notice: "Friend request accepted"
    else
      redirect_to users_path, alert: "Could not accept request"
    end
  end

  def reject
    @friend = Friend.find_by(user_id: params[:id], friend_id: current_user.id)
    if @friend.destroy
      redirect_to users_path, notice: "Friend request rejected"
    else
      redirect_to users_path, alert: "Could not reject request"
    end
  end
end
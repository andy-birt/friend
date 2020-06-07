class UsersController < ApplicationController
  def index
    @users = User.where("id != ?", current_user.id)
    @fr_sent = current_user.friend_requests.where(user_id: current_user.id, accepted: nil)
    @fr_received = FriendRequest.where(receiver_id: current_user.id, accepted: nil)
  end
end

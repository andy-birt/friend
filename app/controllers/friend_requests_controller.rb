class FriendRequestsController < ApplicationController

  before_action :authenticate_user!

  include FriendRequestsHelper
  
  def create
    @fr = FriendRequest.find_by(user_id: params[:user_id], receiver_id: current_user.id, accepted: nil)
    if request_exists?
      create_counter_request
    else
      create_request
    end
  end
  
  def destroy
    @fr = FriendRequest.find_by(user_id: params[:user_id], receiver_id: current_user.id, accepted: true)
    if friends?
      end_friendship
    else
      cancel_request
    end
  end

end

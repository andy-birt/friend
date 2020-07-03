module FriendRequestsHelper
  
  def request_exists?
    !@fr.nil?
  end

  def create_counter_request
    @fr.update(accepted: true)
    if @fr.save
      flash[:success] = "You are now friends with #{@fr.user.full_name}"
      current_user.friend_requests.create(receiver_id: params[:user_id], accepted: true)
      Notification.find_by(notifiable_id: @fr.id).destroy
      redirect_back(fallback_location: authenticated_root_url)
    else
      flash[:danger] = "Someting went wrong"
      redirect_back(fallback_location: authenticated_root_url)
    end
  end

  def create_request
    @friend_request = current_user.friend_requests.create(receiver_id: params[:user_id])
    flash[:info] = "Friend request has been sent"
    Notification.create(receiver: @friend_request.receiver, actor: current_user, action: "sent", notifiable: @friend_request)
    redirect_back(fallback_location: authenticated_root_url)
  end

  def friends?
    !@fr.nil?
  end

  def end_friendship
    if @fr.destroy
      current_user.friend_requests.find_by(receiver_id: params[:user_id]).destroy
      flash[:success] = "You have unfriended #{@fr.user.full_name}"
      redirect_back(fallback_location: authenticated_root_url)
    else
      flash[:error] = "Something went wrong"
      redirect_back(fallback_location: authenticated_root_url)
    end
  end

  def cancel_request
    if cancelled = current_user.friend_requests.find_by(receiver_id: params[:receiver_id])
      Notification.find_by(notifiable_id: cancelled.id).destroy
      cancelled.destroy
      flash[:success] = "Cancelled friend request"
      redirect_back(fallback_location: authenticated_root_url)
    elsif declined = FriendRequest.find_by(user_id: params[:user_id], receiver_id: params[:receiver_id])
      Notification.find_by(notifiable_id: declined.id).destroy
      declined.destroy
      flash[:success] = "Declined friend request"
      redirect_back(fallback_location: authenticated_root_url)
    else
      flash[:error] = "Something went wrong"
      redirect_back(fallback_location: authenticated_root_url)
    end
  end

end

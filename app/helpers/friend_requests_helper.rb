module FriendRequestsHelper
  
  def request_exists?
    !@fr.nil?
  end

  def create_counter_request
    @fr.update(accepted: true)
    if @fr.save
      flash[:success] = "You are now friends with #{@fr.user.email}"
      current_user.friend_requests.create(receiver_id: params[:user_id], accepted: true)
      redirect_to root_url
    else
      flash[:danger] = "Someting went wrong"
      redirect_to root_url
    end
  end

  def create_request
    current_user.friend_requests.create(receiver_id: params[:user_id])
    flash[:info] = "Friend request has been sent"
    redirect_to root_url
  end

  def friends?
    !@fr.nil?
  end

  def end_friendship
    if @fr.destroy
      current_user.friend_requests.find_by(receiver_id: params[:user_id]).destroy
      flash[:success] = "You have unfriended #{@fr.user.email}"
      redirect_to root_url
    else
      flash[:error] = "Something went wrong"
      redirect_to root_url
    end
  end

  def cancel_request
    if cancelled = current_user.friend_requests.find_by(receiver_id: params[:receiver_id])
      cancelled.destroy
      flash[:success] = "Cancelled friend request"
      redirect_to root_url
    elsif declined = FriendRequest.find_by(user_id: params[:user_id])
      declined.destroy
      flash[:success] = "Declined friend request"
      redirect_to root_url
    else
      flash[:error] = "Something went wrong"
      redirect_to root_url
    end
  end

end

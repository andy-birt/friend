class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.where("id != ?", current_user.id)
    @fr_sent = current_user.friend_requests.where(user_id: current_user.id, accepted: nil)
    @fr_received = FriendRequest.where(receiver_id: current_user.id, accepted: nil)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.js { render template: "posts/index.js.erb" }
    end
  end
end

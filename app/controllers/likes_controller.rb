class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    @like = @likable.likes.create(user_id: current_user.id, likable: @likable)
    Notification.create(receiver: helpers.get_user(@likable), actor: current_user, action: "liked", notifiable: @likable) unless helpers.current_user_or_already_liked(@likable)
    respond_to do |format|
      format.html { render partial: "users/shared/likes" }
      format.js 
    end
  end

  def destroy
    @likable.likes.find(params[:id]).destroy
    respond_to do |format|
      format.html { render partial: "users/shared/likes" }
      format.js
    end
  end
end

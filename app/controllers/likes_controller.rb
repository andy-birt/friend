class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create(user_id: current_user.id, post_id: params[:post_id])
    Notification.create(receiver: @post.author, actor: current_user, action: "liked", notifiable: @post) unless helpers.current_user_or_already_liked(@post)
    respond_to do |format|
      format.html { render partial: "users/shared/likes" }
      format.js 
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    Like.find(params[:id]).destroy
    respond_to do |format|
      format.html { render partial: "users/shared/likes" }
      format.js 
    end
  end
end

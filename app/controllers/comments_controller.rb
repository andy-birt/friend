class CommentsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  def new
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  def create
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @post.comments.create(user: current_user, body: params[:body])
    Notification.create(receiver: @post.author, actor: current_user, action: "commented on", notifiable: @post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

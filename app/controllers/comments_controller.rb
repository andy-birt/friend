class CommentsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @comments = @commentable.comments
  end

  def new
    @comments = @commentable.comments
  end

  def create
    @comments = @commentable.comments
    @commentable.comments.create(comment_params)
    author = helpers.get_user(@commentable)
    Notification.create(receiver: author, actor: current_user, action: "commented on", notifiable: @commentable) unless current_user == author
    respond_to do |format|
      format.html { redirect_to @commentable }
      format.js
    end
  end

  def edit
  end

  def update
    @comment = @commentable.comments.find(params[:id])
    @comment.update(comment_params)
    redirect_to user_post_path(@commentable, @commentable)
  end

  def destroy
    current_user.comments.find(params[:id]).destroy
    flash[:success] = "Comment deleted!"
    redirect_to user_post_path(current_user, @commentable)
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :user_id, :commentable_id, :commentable_type)
    end

end

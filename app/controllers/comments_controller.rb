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
    @post.comments.create(comment_params)
    Notification.create(receiver: @post.author, actor: current_user, action: "commented on", notifiable: @post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def edit
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.update(comment_params)
    redirect_to user_post_path(@post.author_id, @post)
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = "Comment deleted!"
    redirect_to user_post_path(params[:user_id], params[:post_id])
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :post, :user)
    end

end

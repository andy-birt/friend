class PostsController < ApplicationController

  before_action :authenticate_user!

  include PostsHelper

  def index
    @posts = Post.where(author: current_user_and_friends).order(created_at: :desc).paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
  end

  def create
    current_user.posts.create(post_params)
    redirect_to root_url
  end

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to authenticated_root_path
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Post was successfully deleted!"
    redirect_to authenticated_root_path
  end

  private

    def post_params
      params.require(:post).permit([:body])
    end

end

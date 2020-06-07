class PostsController < ApplicationController

  before_action :authenticate_user!

  include PostsHelper

  def index
    # Need to filter out posts made by friends, or public, maybe both?? and limit them by 5?
    @posts = Post.where(author: current_user_and_friends).order(updated_at: :desc)
  end

  def new
  end

  def create
    current_user.posts.create(body: params[:post][:body])
    redirect_to root_url
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

end

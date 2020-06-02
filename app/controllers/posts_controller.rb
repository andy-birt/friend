class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    # Need to filter out posts made by friends, or public, maybe both?? and limit them by 5?
    @posts = Post.all
  end

  def new
  end

  def create
    current_user.posts.create(body: params[:post][:body])
    redirect_to root_url
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

end

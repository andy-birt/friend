class PostsController < ApplicationController

  before_action :authenticate_user!

  include PostsHelper

  def index
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
    respond_to do |format|
      format.html
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

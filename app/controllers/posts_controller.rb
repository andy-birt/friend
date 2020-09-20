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
    @post = current_user.posts.build(post_params)
    create_photos if images_present?
    if @post.save
      flash[:success] = "Post was created!"
      redirect_to root_url
    else
      @post.errors.each do |attri, msg|
       flash[:danger] = msg
      end
      redirect_to root_url
    end
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
    @post = current_user.posts.find(params[:id])
    @post.update(post_params)
    redirect_to authenticated_root_path
  end

  def destroy
    current_user.posts.find(params[:id]).destroy
    flash[:success] = "Post was successfully deleted!"
    redirect_to authenticated_root_path
  end

  private

    def post_params
      params.require(:post).permit(:body, photos_attributes: [:caption, :_destroy, image: [].first])
    end

end

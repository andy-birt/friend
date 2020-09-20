class PhotosController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def edit
  end

  def update
    @photo = current_user.photos.find(params[:id])
    @photo.update(photo_params)
    redirect_to(@photo)
  end

  def destroy
    post = current_user.photos.find(params[:id]).post
    if post.photos.count == 1
      post.destroy
    else
      current_user.photos.find(params[:id]).destroy
    end
    flash[:success] = "Photo was successfully deleted!"
    redirect_to authenticated_root_path
  end

  private
    def photo_params
      params.require(:photo).permit(:caption)
    end
end

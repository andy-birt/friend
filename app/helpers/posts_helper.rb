module PostsHelper
  def char_count_high_for(post)
    post[400..-1] unless post.nil?
  end

  def current_user_and_friends
    users = [current_user]
    current_user.friends.each do |friend|
      users << friend
    end
    users
  end

  def images_present?
    params[:post][:photos_attributes].present?
  end

  def create_photos
    params[:post][:photos_attributes].each do |photo|
      @post.photos.build(image: photo.last[:image].first, user_id: current_user.id, caption: photo.last[:caption])
    end
  end
end

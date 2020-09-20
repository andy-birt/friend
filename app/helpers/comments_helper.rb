module CommentsHelper
  def resource_path(resource)
    if resource.is_a?(Post)
      user_post_comments_path(resource.author_id, resource)
    else
      photo_comments_path(resource)
    end
  end

  def new_comment_path(resource)
    if resource.is_a?(Post)
      new_user_post_comment_path(resource.author_id, resource)
    else
      new_photo_comment_path(resource)
    end
  end
end

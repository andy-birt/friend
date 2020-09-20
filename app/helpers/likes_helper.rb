module LikesHelper
  def current_user_or_already_liked(post)
    get_user(post) == current_user || Notification.find_by(actor: current_user, action: "liked", notifiable: post)
  end
end

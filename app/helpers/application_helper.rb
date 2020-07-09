module ApplicationHelper
  def resource
    @resource ||= User.new
  end

  def resource_name
    :user
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def avatar(user, w, h)
    if user.avatar.attached?
      image_tag(user.avatar.variant(resize_to_fill: [w, h]), class: "rounded-circle")
    else
      image_tag("defaultavatar.png", width: w, height: h, class:"bg-secondary rounded-circle")
    end
  end

  def paginate(result)
    content_tag :div, class: "pagination" do
      concat(render_pagination_link "previous", result.current_page - 1, result.current_page <= 1)
      concat(render_pagination_link "next", result.current_page + 1, result.current_page >= result.total_pages)
    end
  end

  def render_pagination_link(label, page, disabled)
    link_to_unless disabled, label, link_path(page)
  end

  def link_path(page)
    controller_path == "posts" ? user_posts_path(user_id: current_user.id, page: page) :
                                 user_path(params[:id], page: page)
  end

  def request_pending_for(user)
    current_user.friend_requests.pluck(:receiver_id).include?(user.id) or user.friend_requests.pluck(:receiver_id).include?(current_user.id)
  end

  def currently_friends_with(user)
    current_user.friends.include?(user)
  end

  def generate_action_button_for(user)
    unless request_pending_for(user)
      link_to "Add Friend", friend_requests_path(user_id: user), method: :create, class: "btn btn-outline-success"
    else
      if currently_friends_with(user)
        link_to "Unfriend", friend_requests_path(user_id: user), method: :delete, class: "btn btn-outline-danger"
      else
        if current_user.friend_requests.find_by(receiver: user)
          link_to "Cancel", friend_requests_path(user_id: current_user, receiver_id: user), method: :delete, class: "btn btn-outline-danger"
        else
          content_tag :div, class: "my-2" do
            concat(link_to "Accept",  friend_requests_path(user_id: user, receiver_id: current_user), method: :create, class: "btn btn-outline-success mr-2")
            concat(link_to "Decline", friend_requests_path(user_id: user, receiver_id: current_user), method: :delete, class: "btn btn-outline-danger")
          end
        end
      end
    end
  end
end

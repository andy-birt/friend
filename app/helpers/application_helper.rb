module ApplicationHelper
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
    link_to_unless disabled, label, user_posts_path(user_id: current_user.id, page: page)
  end
end

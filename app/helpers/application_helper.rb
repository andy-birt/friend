module ApplicationHelper
  def avatar(user, w, h)
    if user.avatar.attached?
      image_tag(user.avatar.variant(resize_to_fill: [w, h]), class: "rounded-circle")
    else
      image_tag("defaultavatar.png", width: w, height: h, class:"bg-secondary rounded-circle")
    end
  end
end

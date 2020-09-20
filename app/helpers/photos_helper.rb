module PhotosHelper
  def arrange(photos, post)
    case(photos.length)
    when(1)
      content_tag(:div, link_to(photo_path(photos.first)) do 
                          image_tag(photos.first.image.variant(resize_to_fill: [670, 400]))
                        end, class: "posts-photos mb-4 mt-2")
    when(2)
      content_tag(:div, class: "posts-photos mb-4 mt-2") do
        concat(link_to(photo_path(photos.first)) do 
                image_tag(photos.first.image.variant(resize_to_fill: [335, 400]), style: "width:50%;", size: "335x400")
              end)
        concat(link_to(photo_path(photos.second)) do 
                image_tag(photos.second.image.variant(resize_to_fill: [335, 400]), style: "width:50%;", size: "335x400")
              end)
      end
    when(3)
      content_tag(:div, class: "posts-photos mb-4 mt-2") do
        concat(link_to(photo_path(photos.first)) do 
                image_tag(photos.first.image.variant(resize_to_fill: [335, 400]), style: "display: block; float: left; width:50%;", size: "335x400")
              end)
        concat(link_to(photo_path(photos.second)) do 
                image_tag(photos.second.image.variant(resize_to_fill: [335, 200]),style: "display: block; float: right; width:50%;", size: "335x200")
              end)
        concat(link_to(photo_path(photos.third)) do 
                image_tag(photos.third.image.variant(resize_to_fill: [335, 200]),style: "width:50%;", size: "335x200")
              end)
      end
    else
      content_tag(:div, class: "posts-photos mb-4 mt-2") do
        concat(link_to(photo_path(photos.first), style: "display:block; float:left; width:50%;" ) do 
                image_tag(photos.first.image.variant(resize_to_fill: [335, 400]), size: "335x400")
              end)
        concat(link_to(photo_path(photos.second), style: "display:block; float:right; width:50%;") do 
                image_tag(photos.second.image.variant(resize_to_fill: [335, 200]), size: "335x200")
              end)
        concat(image_tag(photos.third.image.variant(resize_to_fill: [335, 200]), size: "335x200", style: "width:50%;"))
        concat(link_to(photos_path(post_id: post), class: "photo-overlay", style: "width:50%; height:50%;") do 
                content_tag(:div, "+ #{photos.length - 3}")
              end)
      end
    end 
  end
end

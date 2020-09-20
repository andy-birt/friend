export function arrangePhotos(photos, list = photos) {
  var arrangeMaxPhotos = (el) => {
    $.each(el, (k, child) => {
      console.log(photos)
      if(k !== 0) {
        if($(window).innerWidth() > 768){
          $(child).width("50%");
          $(child).height(200);
        } else {
          $(child).height(200);
          $(child).width($(photos).width() / 2);
        }
      } else {
        if($(window).innerWidth() > 768){
          $(child).width("50%");
          $(child).css("float", "left");
        } else {
          $(child).height(300);
          $(child).width($(photos).width());
        }
      }
    });
  }
  var children = photos[0].children
  if (list.length === 2) {
    $.each(children, (k, child) => {
      $(child).width("50%");
      if($(window).innerWidth() > 768){
        $(child).height(400);
      } else {
        $(child).height(200);
      }
    });
  } else if (list.length >= 3) {
    arrangeMaxPhotos(children);
  } else {
    $(children).width("100%");
  }
}
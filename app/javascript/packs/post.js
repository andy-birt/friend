import { arrangePhotos } from "./modules/arrange_photos";
import { showEditAndDelete, editPhotos, deletePhotos } from "./modules/photo_ud";

$(document).on("turbolinks:load", () => {
  var iArr = [];
  var imgEls = [];
  var post = new FormData($("form")[0]);
  $("#image").on("change", ((event) => {
    var photosElement = $(".photos");
    var photos = event.target.files;
    var images = Array.from(photos);
    iArr.push(images);
    var flattenedImages = iArr.flat();
    images.forEach((image, i) => {
      var reader = new FileReader();
      var img = document.createElement("img");
      reader.onload = (e) => {
        var childCount = photosElement[0].childElementCount;
        var postImages = photosElement[0].children;
        $(img).attr("src", e.target.result);
        $(img).height(400);
        imgEls.push($(img));
        if(childCount < 3){
          photosElement.append(img);
          arrangePhotos(photosElement, postImages);
          if(childCount < 1) {
            $("form[name='post']").find("#post_body").attr({id: "post_photo_attributes_0_caption", name: "post[photo_attributes][0][caption]", placeholder: "Say something about this photo!"});
          } else {
            $("form[name='post']").find("#post_photo_attributes_0_caption").attr({id: "post_body", name: "post[body]", placeholder: "Say something about these photos!!"});
          }
        } else {
          $("form[name='post']").find("#post_photo_attributes_0_caption").attr({id: "post_body", name: "post[body]", placeholder: "Say something about these photos!!"});
          if($(".photos > .photo-overlay").length){
            $(".photos > .photo-overlay").text("+ "+(flattenedImages.length - 3));
          } else {
            var overlay = document.createElement("div");
            $(overlay).attr("class", "photo-overlay");
            $(overlay).width($(photosElement).width() / 2);
            $(overlay).text("+ "+(flattenedImages.length - 3));
            photosElement.append(overlay);
          }
        }
        showEditAndDelete();
      }
      reader.readAsDataURL(image);
    });
    flattenedImages.forEach((img, i) => {
      post.set("post[photos_attributes]["+i+"][image][]", img);
    });
  }));
  $('.edit-photos').on("click", () => editPhotos([iArr, imgEls, post]));
  $('.delete-photos').on("click", () => deletePhotos([iArr, imgEls, post]));
  $('form[name="post"]').on("submit", ((e) => {
    e.preventDefault();
    var postForm = $("form")[0];
    var postBody = postForm[2].value;
    var url = postForm.action;
    post.delete("image");
    if($("form[name='post']").find("#post_body")[0]){
      post.append("post[body]", postBody);
    } else {
      post.append("post[photos_attributes][0][caption]", postBody);
    }
    $.ajax({
      method: "POST",
      url: url,
      contentType: false,
      data: post,
      processData: false,
      success: (res) => { console.log(res) },
      error: (e) => { console.log(e) }
    });
  }));
});
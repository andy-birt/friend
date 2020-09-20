import { arrangePhotos } from "./arrange_photos";

export function showEditAndDelete() {
  if($(".photobackground > .photos")[0].childElementCount < 2) {
    $(".photobackground > .delete-photos").css("display", "block");
    $(".photobackground > .edit-photos").css("display", "block");
    $(".photobackground > .edit-photos").text("Edit Photo");
  } else {
    $(".photobackground > .edit-photos").text("Edit Photos");
  }
}

export function editPhotos(post) {
  var images = Array.from(post[1]);
  var postData = post[2];
  var string = $(".photobackground > .edit-photos").text();
  images.forEach(image => {
    var photo = document.createElement("div");
    var caption = document.createElement("textarea");
    var removePhoto = document.createElement("div");
    var captionText = postData.get("post[photos_attributes]["+images.indexOf(image)+"][caption]") === "undefined" ? "" : postData.getAll("post[photos_attributes]["+images.indexOf(image)+"][caption]");
    if(images.indexOf(image) < 3) {
      var img = $(image).clone();
    } else {
      img = image;
    }
    $(removePhoto).addClass("delete-photo");
    $(removePhoto).html("<div class='line1'></div><div class='line2'></div>");
    $(photo).addClass("photo mb-2");
    $(caption).addClass("caption");
    $(caption).attr({"placeholder": "caption", "name": "post[photos_attributes]["+images.indexOf(image)+"][caption]", "id": "post_photos_attributes_"+images.indexOf(image)+"_caption"});
    $(caption).val(captionText);
    $(img).height(200);
    if($(window).innerWidth() > 515){
      $(img).width("60%");
      $(img).css({"object-fit": "cover", "float": "right"});
    } else {
      $(img).width("100%");
      $(img).css({"object-fit": "cover"});
    }
    $(photo).append(img, removePhoto, caption);
    $("#editPhotos > .modal-dialog > .modal-content > .modal-body").append(photo);
  });
  $(".photobackground > .edit-photos").html(string);
  $("#editPhotos").modal("show");
  $("textarea.caption").on("change", ((e) => {
    postData.set(e.target.name, e.target.value);
  }));
  $('.delete-photo').on("click", (e) => deletePhoto([post[0][0], post[1], post[2], e.target]));
  $("#editPhotos").on("hidden.bs.modal", () => {
    images = Array.from(post[1]);
    images.forEach((v, i) => { 
      postData.set("post[photos_attributes]["+i+"][caption]", $("#post_photos_attributes_"+i+"_caption.caption").val())
    });
    $("#editPhotos > .modal-dialog > .modal-content > .modal-body").html("");
    $("#editPhotos").off("hidden.bs.modal");
  });
}

export function deletePhotos(post) {
  var iArr = post[0][0];
  var postData = post[2];

  iArr.forEach((img, i) => {
    postData.delete("post[photos_attributes]["+i+"][image][]");
    postData.delete("post[photos_attributes]["+i+"][caption]");
  });
  post[0] = [];
  post[1].splice(0, post[1].length);
  $('.photobackground > .photos').empty();
  postData.delete("image");
  if($("form[name='post']").find("#post_photo_attributes_0_caption").length){
    $("form[name='post']").find("#post_photo_attributes_0_caption").attr({id: "post_body", name: "post[body]", placeholder: "Make a post..."});
  } else {
    $("form[name='post']").find("#post_body").attr({placeholder: "Make a post..."});
  }
}

export function deletePhoto(post) {
  var imgEls = post[1];
  var postData = post[2];
  var endOfArr = imgEls.length - 1;

  $(post[3]).parent().remove();

  var i = imgEls.findIndex(x => x[0].src === post[3].previousSibling.src);
  $(imgEls)[i].remove();
  post[0].splice(i, 1);
  post[1].splice(i, 1);
  for(var x = i; x < post[0].length; x++){
    $("textarea.caption")[x].name = "post[photos_attributes]["+x+"][caption]";
    $("textarea.caption")[x].id = "post_photos_attributes_"+x+"_caption";
    postData.set("post[photos_attributes]["+x+"][image][]", postData.get("post[photos_attributes]["+(x+1)+"][image][]"));
    postData.set("post[photos_attributes]["+x+"][caption]", postData.get("post[photos_attributes]["+(x+1)+"][caption]"));
  }
  postData.delete("post[photos_attributes]["+endOfArr+"][image][]");
  postData.delete("post[photos_attributes]["+endOfArr+"][caption]");
  postData.delete("image");
  $(".photos").children().remove();
  imgEls.forEach(img => {
    var childCount = $(".photos").children().length;
    if(childCount < 3){
      $(".photos").append($(img).clone());
      arrangePhotos($(".photos"), $(".photos")[0].children)
    } else {
      $("form[name='post']").find("#post_photo_attributes_0_caption").attr({id: "post_body", name: "post[body]", placeholder: "Say something about these photos!!"});
      if($(".photos > .photo-overlay").length){
        $(".photos > .photo-overlay").text("+ "+(imgEls.length - 3));
      } else {
        var overlay = document.createElement("div");
        $(overlay).attr("class", "photo-overlay");
        $(overlay).text("+ "+(imgEls.length - 3));
        $(".photos").append(overlay);
      }
    }
  });
  if($(".photos").children().length == 0){
    $("form[name='post']").find("#post_body").attr({placeholder: "Make a post..."});
  } else if($(".photos").children().length == 1){
    $("form[name='post']").find("#post_body").attr({placeholder: "Say something about this photo..."});
  } else {
    $("form[name='post']").find("#post_body").attr({placeholder: "Say something about these photos!!"});
  }
}
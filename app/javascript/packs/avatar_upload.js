$(document).on("turbolinks:load", () => {
  $("#user_avatar").on("change", ((event) => {
    image = event.target.files[0]
    var reader = new FileReader();
    reader.onload = (e) => {
      $(".avatar-img > img").css("object-fit", "cover").attr('src', e.target.result);
      $(".avatar-img > img").height(150);
      $(".avatar-img > img").width(150);
    }
    reader.readAsDataURL(image);
  }));
});
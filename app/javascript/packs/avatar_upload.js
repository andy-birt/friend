$(document).on("turbolinks:load", () => {
  $("#user_avatar").change((event) => {
    image = event.target.files[0]
      var reader = new FileReader();
      reader.onload = (e) => {
      $(".avatar-img > img").css("object-fit", "cover").attr('src', e.target.result)
    }
      reader.readAsDataURL(image);
  });
});
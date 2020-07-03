$(document).on("turbolinks:load", () => {
  var posts = $("[class^='post']")
  
  if (posts.length <= 5 && !$("a:contains('next')")[0]) {
    $(".pagination").remove();
  } else {
    $(window).scroll(() => {
      var lastPost = $("[class^='post']").last();
      var nextPage = $("a:contains('next')");
      var offset = lastPost.offset();
      if (nextPage[0]) {
        if (window.pageYOffset + window.innerHeight >= offset.top) {
          $(".pagination").remove();
          $.ajax({
            url: nextPage[0].href,
            dataType: "script",
            method: 'GET'
          })
          .done((res) => res);
        } 
      } else {
        $(".pagination").remove();
      }
    });
  }
});
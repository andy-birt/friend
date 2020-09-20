$(document).on("turbolinks:load", () => {
  if ($("[class^='post-']").length <= 5 && !$("a:contains('next')")[0]) {
    $(".pagination").remove();
  } else {
    $(window).on("scroll", (() => {
      var posts = $("[class^='post-']");
      var lastPost = posts.last();
      var nextPage = $("a:contains('next')");
      var offset = lastPost.offset();
      if (nextPage[0]) {
        if (window.pageYOffset + window.innerHeight >= offset.top) {
          $(".pagination").remove();
          $.ajax({
            url: nextPage[0].href,
            dataType: "script",
            method: 'GET'
          }).done(res => res);
        } 
      } else {
        $(".pagination").remove();
      }
    }));
  }
});
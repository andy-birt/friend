$(document).on("turbolinks:load", () => {
  $(window).scroll(() => {
    var lastPost = $("[class^='post']").last();
    var offset = lastPost.offset();
    var nextPage = $("a:contains('next')");
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
});
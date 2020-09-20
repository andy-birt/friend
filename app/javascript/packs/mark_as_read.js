$(document).on("turbolinks:load", () => {
  $("a[href='/notifications']").on("click", (() => {
    $.ajax({
      url: '/notifications/mark_as_read',
      method: 'POST'
    })
    .done((res) => res)
  }));
});
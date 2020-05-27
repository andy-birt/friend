handleSuccess = (data) => {
  notifications = $.each(data,(key, notification) => {
    $("#notifications").prepend(`<a class='dropdown-item'>${notification.actor} ${notification.action} ${notification.notifiable.type}</a>`)
  });
}

$.ajax({
  url: '/notifications.json',
  dataType: 'JSON',
  method: 'GET',
  success: handleSuccess
});

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("jquery");
require("packs/avatar_upload");
require("packs/mark_as_read");
require("packs/page_scroll");

import "bootstrap"
import "../stylesheets/application"

document.addEventListener("turbolinks:load", () => {
  
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover()

  switch(window.location.pathname) {

    case "/":
      $(".home").addClass("active");
      break;
    case "/notifications":
      $(".notifications").addClass("active");
      break;
    case "/users":
      $(".users").addClass("active");
      break;
  }

});

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

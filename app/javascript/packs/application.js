// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
$(document).ready(function() { 
  $("#search_form").submit(function() {
    var existingHistory = JSON.parse(localStorage.getItem("history"));
    if(existingHistory == null) existingHistory = [];
    var item = $(".blog-text-input").val()
    existingHistory.push(item);
    localStorage.setItem("history", JSON.stringify(existingHistory));
  });
	
  var history = JSON.parse(localStorage.getItem("history") || '[]');
  if(history.length > 0) {
    $('#history-group').show()
    for (var i = 0; i < history.length; i++) {
      var str = '#history' + i
      $(str).text(history[i])
    }
  }
});
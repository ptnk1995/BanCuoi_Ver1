// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery.countdown


var countdown = function() {
  $('#clock').countdown({ //clock là thẻ chứa bộ đếm đồng hồ
    until: $('#remaining_time').val(), //thời gian đếm
    format: 'HMS', //định dạng thời gian
    onExpiry: function() {
      $('.submit-time-out').hidden(); //submit khi hết giờ
    }
  });
}

document.addEventListener('turbolinks:load', countdown);
$(document).on('page:update', countdown);

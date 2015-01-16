// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


function notyMessage(type,msg) {
  switch (type) {
    case 'alert':
      var notyType = 'error';
      var notyTimeout = 6000;
      break;
    case 'notice':
      var notyType = 'success';
      var notyTimeout = 5000;
      break;
    default:
      var notyType = type;
      var notyTimeout = 4000;
  };
  var n = noty({
    layout: 'topCenter',
    timeout: notyTimeout,
    text: msg,
    type: notyType,
  });
};

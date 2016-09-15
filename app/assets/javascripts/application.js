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
//= require turbolinks
//= require bootstrap-sprockets
//= require toastr
//= require moment
//= require fullcalendar
//= require fullcalendar/lang-all
//= require bootstrap-datetimepicker
//= require jquery.minicolors
//= require cocoon
//= require theme

$(document).ready(function(){

  $('.colorpicker').minicolors({
    theme: 'bootstrap'
  });

  $('.datetimepicker').datetimepicker({
    locale: 'fr',
    format: "DD/MM/YYYY hh:mm",
    icons: {
      time: 'fa fa-time',
      date: 'fa fa-calendar',
      up: 'fa fa-chevron-up',
      down: 'fa fa-chevron-down',
      previous: 'fa fa-chevron-left',
      next: 'fa fa-chevron-right',
      today: 'fa fa-crosshairs',
      clear: 'fa fa-trash',
      close: 'fa fa-remove'
    }
  });

})

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
//= require popper
//= require moment
//= require bootstrap
//= require toastr
//= require fullcalendar
//= require fullcalendar/locale-all
//= require jquery.minicolors
//= require cocoon
//= require sb-admin/sb-admin-2

$(document).ready(function(){

  // $('.colorpicker').minicolors({
  //   theme: 'bootstrap'
  // });

  // $('.datetimepicker').datetimepicker({
  //   locale: 'fr',
  //   format: "DD/MM/YYYY hh:mm A",
  //   sideBySide: true,
  //   icons: {
  //     time: 'fa fa-clock-o',
  //     date: 'fa fa-calendar',
  //     up: 'fa fa-chevron-up',
  //     down: 'fa fa-chevron-down',
  //     previous: 'fa fa-chevron-left',
  //     next: 'fa fa-chevron-right',
  //     today: 'fa fa-crosshairs',
  //     clear: 'fa fa-trash',
  //     close: 'fa fa-remove'
  //   }
  // });

  $('.category_select').on('change', function(){
    member_id = $(this).data('member-id');
    category = $(this).val()

    if(member_id){
      change_category(member_id, category)
    }
  });

});

function change_category(member_id, category){
  $.ajax({
    url: '/members/'+member_id+'.js',
    method: 'PATCH',
    data: {'member': {'category': category}},
    success: function(){
      toastr.success('Membre mis à jour')
    }
  })
}

function init_fullCalendar(selector, sources, selectable, new_event_link){
  $(selector).fullCalendar({
    lang: 'fr',
    selectable: selectable,
    header: {
      left: 'prev, next, today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay,listWeek'
    },
    navLinks: true,
    eventLimit: true,
    eventSources: sources,
    select: function(startDate, endDate){
      $.ajax({
        url: new_event_link,
        data: {start_at: startDate.format(), end_at: endDate.format()}
      });
    },
    eventClick: function(calEvent, jsEvent, view) {
      jsEvent.preventDefault();
      if(!$(jsEvent.currentTarget).hasClass('not-editable')){
        $.ajax({
          url: calEvent.url
        });
      }
    }
  });
}

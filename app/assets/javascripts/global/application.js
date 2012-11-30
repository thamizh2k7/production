// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require ./underscore.js
//= require ./jquery-ui-1.9.1.custom.min.js
//= require_tree .

$(document).ready(function(){
	$("#resources_button").click(function(){
		$("#resources_dialog").dialog("open");
	});

	$("#static_page_dialog").dialog({
		autoOpen: false,
		draggable: false,
		height: 700,
		width: 1100,
		resizable: false,
		buttons: {
              Ok: function () {
                  $(this).dialog("close");
              }
          },
    modal: true
	});

	$(".static_page_dialog_open").click(function(){
		current = $(this).attr("href");
		$("#static_page_dialog .sub").hide();
		$(current).show();
		$("#static_page_dialog").dialog("open");
		return false;
	});
	$("#university_dialog").dialog({
			autoOpen: false,
			title:'Universities',
			draggable: false,
			dialogClass: 'user_dialog',
			height: 500,
			width: 1000,
			resizable: false,
      modal: true
	});
	$(".open_university").click(function(){
			$("#university_dialog").dialog("open");	
	});
	$(".rails_notice").delay(5000).fadeOut(300);
});
//=require jquery
//=require global/jquery.validate.min
//=require global/jquery-ui-1.10.0.tabs.min.js


$(document).ready(function(){

	$("#body_content").css({"min-height" : ($(window).height()- $("#footer").height() - 60)});
});
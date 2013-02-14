$(document).ready(function(){
	$(".action_icon").tooltip();
	
	$('#enable').click(function() {
		$(this).toggleClass('active');
		if ($('.canEdit').hasClass('editable')){
			$('.canEdit').editable('toggleDisabled');
			$(this).children().attr('data-original-title','Edit Item');
		}
		else {
			$('.canEdit').editable();
		}

		if ($(this).hasClass('active')){
			$(this).children().attr('data-original-title','Please click on blue text to edit');
		}
   });   

});
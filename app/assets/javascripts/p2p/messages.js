/*
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
*/

	$(document).ready(function(){


		// check or uncheck all the messages in the table
		$(".master_check").change(function(){

			var that = $(this);

			

			_.each($("#" + that.attr("tbl") + "_table").find('.msg_check'),function(elm){

					if (that.attr('checked')){
						$(elm).attr('checked','checked');
					}
					else{
						$(elm).removeAttr('checked');	
					}

					// toggle the checkbox

					// if ($(elm).attr('checked')){
					// 	$(elm).removeAttr('checked');
					// }else{
					// 	$(elm).attr('checked','checked');
					// }
			});
			//$("#" + that.attr("tbl") + "_table").children(".msg_check").toggle();

		});


		//select the particular row if its checkbox is selected
		$(".msg_check").change(function(){

		});
		
		// delete selected messages
		$('.delete_messsage').click(function(){
			var that = $(this);

			var delete_messages = [];

			//get all the messages that are checked
			_.each($("#" + that.attr("tbl") + "_table").find('.msg_check'),function(elm){
					if ($(elm).attr('checked')){
						delete_messages.push($(elm).attr('msgid'));
					}
			});

			//if nothing is selected reutnr 
			if (delete_messages.length < 0 ){
				alert('Please select atleast one message');
				that.removeAttr('checked')
				return false;
			}
			
			showOverlay();

			// delete the messages using ajax
			$.ajax({
				url:'/p2p/messages/0',
				data:{msgid:delete_messages , tbl: that.attr('tbl')},
				type:'delete',
				dataType:'json',
				success:function(data){

					// reset the checkbox
					that.removeAttr('checked');

					if (data['unreadcount'] > 0){
						$('#inbox_count').html("(" + data['unreadcount'] +  ")");
					}
					else{
						$('#inbox_count').html("");
					}


					// redraw the table
					if (that.attr("tbl")=='inbox'){
						oInboxTable.fnDraw();
						console.log(oInboxTable);
					}else if (that.attr("tbl")=='sentbox') {
							oSentBoxTable.fnDraw();
					}
					else if  (that.attr("tbl")=='deletebox') {
							oDeleteBoxTable.fnDraw();
					}

					// #hide the overloy
					$("#overlay").hide();
				}
			});

		});



	});


 	// Showing overlay while fetching contents
	showOverlay = function(){
		
		$("#overlay").css({
			"width":$(".tab-content").outerWidth(),
			"height":$(".tab-content").outerHeight(),
			"top":$(".tab-content").top,
			"left":$(".tab-content").offset().left,
		});
		$("#overlay").show();
	}


// //
// add row to dataTables
// function fnClickAddRow() {
// 	$('#example').dataTable().fnAddData( [
// 		giCount+".1",
// 		giCount+".2",
// 		giCount+".3",
// 		giCount+".4" ] );
	
// 	giCount++;
// }
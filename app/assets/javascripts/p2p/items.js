$(document).ready(function(){


	// save the form onclick trigger
	$("#save").click(function(){

		// call the save function if saved not return false
		if (!saveItem()){
			return false;
		}


	});



	// cancel edit function trigger
	// #TODO: CHECK IF THE FORM IS CHANGED OR NOT AND REDIRECT ACCORDINGLY
	$("#cancel").click(function(){
			window.location.reload();
	});

	// EDIT Button click function..
	// if edit is pressed for first time then open all editable elements
	// 	if in edit rather than new dn enable the category and brand for edition
	// if edit is pressed for second time then try to toggle all the editable elements to normal
	$('#enable').click(function() {
		$(this).toggleClass('active');

		//close all editable elements
		if ($('.canEdit').hasClass('editable')){

			$("#add_more_spec").addClass('hide');

			$("#upload_pic").addClass('hide');

			$("#empty_specs").addClass('hide');

			$("#title").css({'color':""});

			$('.canEdit').editable('toggleDisabled');

			$("#title").editable('toggleDisabled');

			$("#category").editable('toggleDisabled');

			$(this).children().attr('data-original-title','Edit Item');

			// disable upload form
			$("#file_add_image").attr("disabled","disabled");

			$(".remove_image").css({'display':'block'});

			$(this).removeClass('btn-primary').attr('title','Edit Listing');

			// replace the edit icon
			// #TODO: REMOVE THIS NOT NEEDED IN FUTURE
			$("#enable i").addClass('icon-pencil');
			$("#enable i").removeClass('icon-ok');
			$("#enable i").attr('title','Edit Listing');
		}
		//Enable all the edits here.
		else {
			// show all the tooltips
			$("#title").tooltip('show');

			// hide the edit button and show the save and cancel button
			$("#enable").hide();
			$("#save").show();
			$("#cancel").show();

			$(this).addClass('btn-primary').attr('title','Save Changes');

			$("#enable i").attr('title','Click here to save your changes');
			$("#enable i").removeClass('icon-pencil');
			$("#enable i").addClass('icon-ok');
			
			// enable upload form
			// $("#file_add_image").removeProp("disabled");
			$("#file_add_image").removeAttr("disabled");

			$(".remove_image").css({'display':'block'});
			$("#add_more_spec").removeClass('hide');

			//enable the remove image butotn

			$("#upload_pic").removeClass('hide');

			$('.canEdit').editable();

			if (window.edit){
				$("#category").editable('toggleDisabled');
				$('[id^=item_]').on('save',check_specs);
			}

			$("#title").css({'color':'blue'});
			$("#title").editable({
				placement:'bottom'
			});

			$("#empty_specs").removeClass('hide');


			window.try = 0;
			$("#category").on('save',function(e,params){
				//set_category(params.newValue);


				if (params.newValue == item_values['cat']) return false ;

				$(".specs").remove();

				item_values['spec']={};
				

				//$('#model').removeClass('editable').removeClass('editable-click').removeClass('editable-unsaved');
				var temp = $('#model').parent().html();
				var par = $('#model').parent();
				$(par).html(temp);
				$("#model").html("Select one");
				$("#model").attr("data-source",'/p2p/getbrand/' + params.newValue);
				item_values['brand'] = '';


				//$("#model").editable({sourceCache:false});
				
				//$("#model").destroy();
				$("#model").editable();

						//set model save handler
						//validate location
						$('#model').on('save', function(e, params) {
			   				 //alert('Saved value: ' + params.newValue);
			   				 //alert('saving');
							if (params.newValue != "") {
								item_values['brand'] = params.newValue;
								$(this).removeClass('error');

								$("#price").tooltip('show');
							}
							else{
								item_values['brand']="";
								params.newValue = params.oldValue;
								$(this).addClass('error');
								$("#model").tooltip('show');
							}
						});



				
				showNotifications("Fetching specifications...! Please Wait..");

				$.ajax({
					url:'/p2p/getattributes/' + params.newValue,
					type:"get",
					success:function(data){

						$('#table_specs .cat_spec').remove();
						$(data).insertAfter($('#table_specs tr:last '));
						$("[id^=item_]").editable();

						//validate specification
							$('[id^=item_]').on('save',check_specs);

					},
					error:function(){

						$('#table_specs .cat_spec').remove();
						$('<tr class="error cat_spec"><td colspan = 2 >Specifications were not loaded. Something went wrong. Try again</td></tr>').insertAfter($('#table_specs tr:last '));

						showNotifications('Some Error Occured. Please Try again');
					}

				});

				$('#model').tooltip('show');
			});



			// //validate brand
			// $('#category').on('save', function(e, params) {
   // 				 //alert('Saved value: ' + params.newValue);
			// 	if (params.newValue != "") {
			// 		item_values['title'] = params.newValue;


			// 		$(this).removeClass('error');
			// 	}
			// 	else{
			// 		item_values['title']="";
			// 		params.newValue = params.oldValue;
			// 		$(this).addClass('error');
			// 	}
			// });



			//validate title
			$('#title').on('save', function(e, params) {
   				 //alert('Saved value: ' + params.newValue);
				if (params.newValue.length > 5) {
					item_values['title'] = params.newValue;
					$(this).removeClass('error');
					$('#category').tooltip('show');
				}
				else{
					item_values['title']="";
					params.newValue = params.oldValue;
					$(this).addClass('error');
					$(this).tooltip('show');
				}
			});

			// window.url = '/p2p'
			// $('#model').editable({
  	// 		selector: 'a',
  	// 		url: window.url,
  	// 		pk: 1
			// });

			//validate price
			$('#price').on('save', function(e, params) {
   				 //alert('Saved value: ' + params.newValue);
				if (params.newValue.match(/^\d+$/) != null) {
					item_values['price'] = params.newValue;
					$(this).removeClass('error');
					$("#condition").tooltip('show');

				}else{
					item_values['price']="";
					params.newValue = params.oldValue;
					$(this).tooltip('show');
				}
			});

			//validate location
			$('#location').on('save', function(e, params) {
   				 //alert('Saved value: ' + params.newValue);
				if (params.newValue.length > 3) {
					item_values['location'] = params.newValue;
					$(this).removeClass('error');
					$('[id^=item_] :first').tooltip('show');
				}
				else{
					item_values['location']="";
					params.newValue = params.oldValue;
					$(this).addClass('error');
					$(this).tooltip('show');
				}
			});


			//validate condition
			$('#desc_content').on('save', function(e, params) {
   				 //alert('Saved value: ' + params.newValue);
   				 params.newValue = $.trim(params.newValue);

				if (params.newValue.length > 20) {
					item_values['desc'] = params.newValue;
					$(this).removeClass('error');
					$('#save i').tooltip('show');
				}
				else{
					item_values['desc']="";
					params.newValue = params.oldValue;
					$(this).addClass('error');
					$(this).tooltip('show');
				}
			});


			//validate condition
			$('#condition').on('save', function(e, params) {
   				 //alert('Saved value: ' + params.newValue);
   				 params.newValue = $.trim(params.newValue);

				if (params.newValue.length > 2) {
					item_values['condition'] = params.newValue;
					$(this).removeClass('error');
					$("#location").tooltip('show');
				}
				else{
					item_values['condition']="";
					params.newValue = params.oldValue;
					$(this).addClass('error');
					$(this).tooltip('show');
				}
			});

		}

		if ($(this).hasClass('active')){
			$(this).children().attr('data-original-title','Please click on blue text to edit');
		}
   });   


	$("#file_add_image").change(function(){
		$("#add_image_form").submit();
	});



	//delete the item
    $("#delete_button").click(function(){
    	// if user says no stop deleting 
    	if (!confirm("Are you sure you want to delete this listing?")){
    		return true;
    	}

	    $.ajax({
	      url:"/p2p/items/" + $(this).attr("itemid"),
	      type:"delete",
	      dataType:"json",
	      data:{"authenticity_token" : AUTH_TOKEN},
	      success:function(data){
	        if (data.status == 1){
	          window.location.href="/p2p/mystore"
	        }
	      }
	    });
  });


	//remove image funciton
	$(".remove_image").click(function(){
		var that = $(this);
		$.ajax({

			url:"/p2p/images/" + that.siblings('img').attr("imgid"),
			type:"delete",
			dataType:"json",
			data:{"authenticity_token" : AUTH_TOKEN},
			success:function(data){
				if (data.status == 1){
					var imgid = that.siblings('img').attr("imgid");
					that.parent().remove();
					$(".thumbs :first").trigger("click");
				}
			}
		});
	});



			saveItem = function(){



				if (!('title' in item_values) || item_values['title'] == ""){
					$("#title").addClass("error");
					$("#title").tooltip('show');
					return false;
				}
				

				if (!('brand' in item_values) || item_values['brand'] == ""){
					$("#model").addClass("error");
					$("#model").tooltip('show');
					return false;
				}

				if (!('price' in item_values) || item_values['price'] == ""){
					$("#price").addClass("error");
					$("#model").tooltip('show');
					return false;
				}

				if (!('condition' in item_values) || item_values['condition'] == ""){
					$("#condition").addClass("error");
					$("#condition").tooltip('show');
					return false;
				}

				if (!('desc' in item_values) || item_values['desc'] == ""){
					$("#item_desc").addClass("error");
					$("#item_desc").tooltip('show');
					alert("Enter item description");
					return false;
				}


				var flag = 1;

				_.each(item_values['spec'],function(value,key){
					$("#item_" + key).removeClass("error");
					if (value == ""){
						$("#item_" + key).addClass("error");
						$("#item_" + key).tooltip('show');
					}else{
						flag =  0;
					}
				});

				if (flag){
					alert(" Enter Specifications" );
					return false;
				}


				//showOverlay();
				showNotifications('Saving item..! Please wait..!');

				item_values['authenticity_token']= AUTH_TOKEN;
				$.ajax({
					url:window.editsaveurl,
					data:item_values,
					type:window.editsavetype,
					success:function(data){
						if (data['status'] == 1){
							window.location.href = "/p2p/" + data['id']
						}
						else{
							alert(data['status']);
						}
					}
				});

			};


	      $('#approve').on('click',function(){
	          var that  = $(this);

	          $.ajax({
	            url:'/p2p/approve/approve',
	            data:{id: that.attr('itemid')},
	            dateType:'json',
	            type:'post',
	            success:function(data){
	                if (data ==  1) {
	                  showNotifications('Item Approved');
	                  that.remove();
	                }
	                else{
	                  showNotifications('Something went wrong');
	                }
	            },
	            error:function(){
	                showNotifications('Something went wrong');
	            }
	          });
	      });

	      $('#disapprove').on('click',function(){
	          var that  = $(this);

	          $.ajax({
	            url:'/p2p/approve/disapprove',
	            data:{id: that.attr('itemid')},
	            dateType:'json',
	            type:'post',
	            success:function(data){
	                if (data ==  1) {
	                  showNotifications('Item Disapproved');
	                  that.remove();
	                }
	                else{
	                  showNotifications('Something went wrong');
	                }
	            },
	            error:function(){
	                showNotifications('Something went wrong');
	            }
	          });
	      });	      


	      $('.thumbs').click(function(){
	      		$('#view_image').attr('src',$(this).children('img').attr("viewimage"));
	      		$('#view_image').attr('imgid',$(this).children('img').attr("imgid"));
	      });


});


check_specs =  function(e, params) {
				   				 //alert('Saved value: ' + params.newValue);
				   				 var that = $(this);

				   				if (params.newValue.length > 0) {

									if (params.newValue.length > 1) {
										item_values['spec'][that.attr('specid')] = params.newValue;
										$(this).removeClass('error');
										
										if ($('[id^=item_]')[Number($(this).attr('specid')) ]){

											$($('[id^=item_]')[Number($(this).attr('specid'))]).tooltip('show');
										}
										else{
											$(window).scrollTop = $("#desc_content").top;
											$("#desc_content").tooltip('show');
										}
									}
									else{
										item_values['spec'][that.attr('specid')]="";
										params.newValue = params.oldValue;
										$(this).addClass('error');
										$(this).tooltip('show');
									}
								}
								else{
									item_values['spec'][that.attr('specid')]="";
									$(this).tooltip('show');
								}

							}

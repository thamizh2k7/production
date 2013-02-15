$(document).ready(function(){

	//set initializing data

	//set tooltip
	$('#enable').click(function() {
		$(this).toggleClass('active');
		if ($('.canEdit').hasClass('editable')){


			if (!saveItem()){
				return false;
			}

			$("#empty_specs").addClass('hide');

			$("#item_title").css({'color':""});

			$('.canEdit').editable('toggleDisabled');

			$("#item_title").editable('toggleDisabled');

			$("#item_category").editable('toggleDisabled');

			$(this).children().attr('data-original-title','Edit Item');

			// disable upload form
			$("#file_add_image").attr("disabled","disabled");

			$(".remove_image").css({'display':'block'});

			$(this).removeClass('btn-primary').attr('title','Edit Listing');
		}
		else {

			$(this).addClass('btn-primary').attr('title','Save Changes');

			// enable upload form
			// $("#file_add_image").removeProp("disabled");
			$("#file_add_image").removeAttr("disabled");

			$(".remove_image").css({'display':'block'});

			//enable the remove image butotn

			$('.canEdit').editable();

			$("#item_title").css({'color':'blue'});
			$("#item_title").editable({
				placement:'bottom'
			});

			$("#empty_specs").removeClass('hide');


			$("#category").on('save',function(e,params){

				console.log(params.newValue);

				if (params.newValue != 0){
					$.ajax({
						url:'/p2p/getbrand/' + params.newValue,
						type:"get",
						async:false,
						success:function(data){
								$("#model").attr('data-source',JSON.stringify(data));
						}
					});
				}
			});

			//validate location
			$('#item_title').on('save', function(e, params) {
   				 //alert('Saved value: ' + params.newValue);
				if (params.newValue.length > 5) {
					item_values['title'] = params.newValue;
					$(this).removeClass('error');
				}
				else{
					item_values['title']="";
					params.newValue = params.oldValue;
					$(this).addClass('error');
				}
			});



			//validate price
			$('#item_price').on('save', function(e, params) {
   				 //alert('Saved value: ' + params.newValue);
				if (params.newValue.match(/^\d+$/) != null) {
					item_values['price'] = params.newValue;
					$(this).removeClass('error');
				}else{
					item_values['price']="";
					params.newValue = params.oldValue;
				}
			});

			//validate location
			$('#item_location').on('save', function(e, params) {
   				 //alert('Saved value: ' + params.newValue);
				if (params.newValue.length > 3) {
					item_values['location'] = params.newValue;
					$(this).removeClass('error');
				}
				else{
					item_values['location']="";
					params.newValue = params.oldValue;
					$(this).addClass('error');
				}
			});


			//validate condition
			$('#desc_content').on('save', function(e, params) {
   				 //alert('Saved value: ' + params.newValue);
   				 params.newValue = $.trim(params.newValue);

				if (params.newValue.length > 20) {
					item_values['desc'] = params.newValue;
					$(this).removeClass('error');
				}
				else{
					item_values['desc']="";
					params.newValue = params.oldValue;
					$(this).addClass('error');
				}
			});


			//validate condition
			$('#item_condition').on('save', function(e, params) {
   				 //alert('Saved value: ' + params.newValue);
   				 params.newValue = $.trim(params.newValue);

				if (params.newValue.length > 2) {
					item_values['condition'] = params.newValue;
					$(this).removeClass('error');
				}
				else{
					item_values['condition']="";
					params.newValue = params.oldValue;
					$(this).addClass('error');
				}
			});

			//validate specification
			$('[id^=item_]').on('save', function(e, params) {
   				 //alert('Saved value: ' + params.newValue);
   				 var that = $(this);
   				 console.log(that);

   				if (params.newValue.length > 0) {

					if (params.newValue.length > 3) {
						item_values['spec'][that.attr('specid')] = params.newValue;
						$(this).removeClass('error');
					}
					else{
						item_values['spec'][that.attr('specid')]="";
						params.newValue = params.oldValue;
						$(this).addClass('error');
					}
				}
				else{
					item_values['spec'][that.attr('specid')]="";
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

	$(".remove_image").click(function(){
		console.log();
	});



	//delete the item
    $("#item_delete_button").click(function(){
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
	      	console.log(data);
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

				// if (!('cat' in item_values) || item_values['cat'] == "") {
				// 	$("#item_category").addClass("error");
				// 	alert("Select a category");
				// 	return false;
				// }

				// if (!('brand' in item_values) || item_values['cat'] == "") {
				// 	$("#item_brand").addClass("error");
				// 	alert("Select a Brand");
				// 	return false;
				// }

				if (!('title' in item_values) || item_values['title'] == ""){
					$("#item_title").addClass("error");
					alert("Enter item title");
					return false;
				}

				if (!('price' in item_values) || item_values['price'] == ""){
					$("#item_price").addClass("error");
					alert("Enter item price");
					return false;
				}

				if (!('condition' in item_values) || item_values['condition'] == ""){
					$("#item_condition").addClass("error");
					alert("Enter item condition");
					return false;
				}

				if (!('desc' in item_values) || item_values['desc'] == ""){
					$("#item_desc").addClass("error");
					alert("Enter item description");
					return false;
				}


				var flag = 1;

				_.each(item_values['spec'],function(value,key){
					$("#item_" + key).removeClass("error");
					if (value == ""){
						$("#item_" + key).addClass("error");
					}else{
						flag =  0;
					}
				});

				if (flag){
					alert(" Enter Specifications" );
					return false;
				}


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

});
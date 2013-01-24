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
    modal: true
	});

	$(".static_page_dialog_open").click(function(){
		current = $(this).attr("href");
		// page=current.replace("_"," ")
		// page=page.slice(1).toUpperCase()
		
		$("#static_page_dialog").dialog('option','title',$(current).attr('title'))
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
	if($("#page_not_found").html().trim()!="")
		$("#page_not_found").fadeIn(1000).delay(5000).fadeOut(300);
	$(".rails_notice").delay(5000).fadeOut(300);

//start router on page load



//my own code

//trigger hash once	


	if (/^book\/\d{13}/i.test(window.location.hash.substr(1)) ){

	  	$.ajax( {
	  		url:"/" + window.location.hash.substr(1),
	  		dataType:"json",
	  		success:function(data){
				sociorent.collections.search_object.reset(data);
				sociorent.fn.renderSearch();
				$(".search_books_single").trigger("click");
			}
		});
	 }

  });




	
  // 	$.ajax( {
  // 		url:"/" + window.location.hash.substr(1),
  // 		dataType:"json",
  // 		success:function(data){

  // 			//if sucess clear teh review
  // 			$(".reviews_content").html("");

  // 			//initialize the template
  // 			var temp = _.template($("#book_details_template").html());
  // 			var review = _.template($("#review_template").html());

  // 			//open the dialog with data filled
		// 	$("#book_details_box").html(temp(data)).dialog("open");//.css({top:0,position:fixed});

		// 	//add teh review  this order must be maintained
  // 			for (var i in data.reviews )
  // 			{
  // 				$(".reviews_content").append(review(data.reviews[i]));
  // 			}
  // 			$(".reviews_content").show();

		// 	if $.inArray(@model.id, sociorent.models.user_object.get("wishlist")) > -1
		// 		@$(".add_to_wishlist").html "Already in your Wishlist."
		// 	if sociorent.collections.cart_object.get(@model.id)
		// 		@$(".add_to_cart").css
		// 			background: "#0F8159"
		// 			cursor: 'default'


  			
 	// 		$(".add_to_cart").click(function(){
		// 		$.ajax("/home/add_to_cart", {
		// 			  type: "post",
		// 			  async: true,
		// 			  data: {
		// 			    book: data.id
		// 			  },
		// 			  success: function(msg) {
		// 			    sociorent.fn.hide_notification();
		// 			    sociorent.collections.cart_object.add(msg);
		// 			    return sociorent.fn.renderCart();
		// 			  }
		// 			});
		// 		});


  // 			//on reivew submit perfom add review

		// 	$(".reviews_form").submit(function(){

		// 	semester = $.trim($("#review_semester").val())

		// 	content = $.trim($("#review_text_content").val())

		// 	if(semester == "") {
		// 		alert("Please enter your Semester Eg: 1");
		// 		return false;
		// 	}
		// 	if(content == ""){
		// 		alert("Please write your review before submitting");
		// 		return false;
		// 	}
		// 	else{

		// 		console.log(data);
		// 		sociorent.fn.show_notification();

		// 		$.ajax({
		// 			url:"/home/make_review",
		// 		  	type: "post",			
		// 			async: true,
		// 		  	data: {
		// 		    book: data.id,
		// 		    content: content,
		// 		    semester: semester
		// 		  	},
		// 		  	success: function(msg) {
		// 			    sociorent.fn.hide_notification();
		// 			    $(".reviews_form").hide();
		// 			    $(".reviews_input").val("").show();

		// 				$(".reviews_content").append(review(msg));
		// 			  	}
		// 		});

		// 		return false;
		// 	}
		// });




// var Router = Backbone.Router.extend({
//   routes: {
//   	"" : "index",
//     "book/:isbn" : "showbook"
//   },
//   initialize: function() {

//   	var that = this;

// 	this.route("book", "showbook", function() {
//       that.showbook();
//     });

//   },

//   showbook: function(isbn) {
//   	$.ajax( {
//   		url:"/book/" + isbn ,
//   		dataType:"json",
//   		success:function(data){

//   			$(".reviews_content").html("");

//   			var temp = _.template($("#book_details_template").html());
//   			var review = _.template($("#review_template").html());

// 			$("#book_details_box").html(temp(data)).dialog("open");//.css({top:0,position:fixed});

//   			for (var i in data.reviews )
//   			{
//   				$(".reviews_content").append(review(data.reviews[i]))
//   			}
//   			$(".reviews_content").show();
// 			// view = new sociorent.views.review({model: data.reviews });

// 			// $(".reviews_content").append(view.render().el)
// 	  	},
// 	  	error:function(){
// 	  		alert("err");
// 	  	}
//   	});
//   }

// });

// 	var app_router = new Router();

// 	Backbone.history.start();




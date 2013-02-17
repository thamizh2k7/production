
	
		$(document).ready(function(){



				$('#Itemlist .navbar').scrollToFixed();
				$('#filters').scrollToFixed();
				$('#browse_menu').scrollToFixed({bottom: -30});

//				$('#Itemlist #items').scrollToFixed();

// 			// dont execute thsi for places where they are not defined
// //			if ($('#browse_menu').length ==0 ) return ; 

			
// 			fixToTop('#browse_menu',0,$('#browse_menu').offset().left,$('#browse_menu').outerWidth());
// 			fixToTop('#filters',0,$('#filters').offset().left),$('#filters').outerWidth();

// 			fixToTop('#Itemlist .navbar',0,$('#Itemlist .navbar').offset().left,$('#Itemlist .navbar').outerWidth());


// 			fixLeft('#Itemlist #items',$('#Itemlist #items').offset().left);
 
// 		});
	 


// 		//fixes particular element to top

// 		function fixLeft (selector,left) {

// 				if ($(selector).length == 0 ) return false;
// 						//browse  menu			
// 				var browseTop = $(selector).offset().top;

// 				 $(window).scroll(function(){ // scroll event
		 
// 		 		   var windowTop = $(window).scrollTop(); // returns number

// 		 		      if (browseTop < windowTop) {
// 		      				$(selector).css({ position: 'fixed',
// 		      								 left:left
// 		      								  });
// 		    			}
// 		    		else {
// 		      			$(selector).css('position','static');
// 		    		}
// 		 		});

// 		}

// 	function fixToTop(selector,top,left,width){

// 				if ($(selector).length == 0 ) return false;
// 						//browse  menu			
// 				var browseTop = $(selector).offset().top;

// 				 $(window).scroll(function(){ // scroll event
		 
// 		 		   var windowTop = $(window).scrollTop(); // returns number

// 		 		      if (browseTop < windowTop) {
// 		      				$(selector).css({ position: 'fixed',
// 		      								 top: top,
// 		      								 left:left,
// 		      								 width:width
// 		      								  });
// 		    			}
// 		    		else {
// 		      			$(selector).css('position','static');
// 		    		}
// 		 		});


	});
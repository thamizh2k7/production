
	
		$(document).ready(function(){



				$('#Itemlist .navbar').scrollToFixed();
//				$('#filters').scrollToFixed();
//				$('#browse_menu').scrollToFixed({bottom: -30});

				$(window).scroll(function(){
						var stop =  $(window).scrollTop() > ($("#dummy_filter_holder").offset().top + $("#dummy_filter_holder").height() -100) ;
						var sbot = ($(window).scrollTop() + $(window).height() ) < ($("#dummy_filter_holder").offset().top ) ;
						if ( stop || sbot){
							$("#pull_here").css({'display':'block'});

							$("#pull_here").clearQueue().animate({
								top: ( $(window).scrollTop() + ( $(window).height()/2)  )
							});


						}else{
							$("#pull_here").css({'display':'none'});
						}
				});

				var filter_initial_height = $("#dummy_filter_holder").offset().top;

				$("#pull_here").click(function(){

					$("#pull_here").css({'display':'none'});


					if ( ($(window).scrollTop() +  $("#dummy_filter_holder").outerHeight()  ) > $(document).height() ){
							$("#dummy_filter_holder").clearQueue().animate({top:(  ($(document).height() -130) - $("#dummy_filter_holder").outerHeight()  ) });	
					}else{
							$("#dummy_filter_holder").clearQueue().animate({top:$(window).scrollTop() });	
					}
					
					if (	parseInt($("#dummy_filter_holder").css('top')) > filter_initial_height) {
							$("#dummy_filter_holder").clearQueue().animate({'top':filter_initial_height});
					}

				});
	});
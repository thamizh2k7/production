
		function filter(spec,val,that){

			
			if (spec in filters){
				if (filters[spec].indexOf(val) == -1){
					filters[spec].push(val)
					$(that).addClass('active');
					$(that).children(".icon-remove").removeClass("hide");

				}else{
					filters[spec].splice(filters[spec].indexOf(val),1)
					$(that).removeClass('active');
					$(that).children(".icon-remove").addClass("hide");
				}
			}
			else{
				filters[spec]=[]
				filters[spec].push(val)
				$(that).addClass('active');
				$(that).children(".icon-remove").removeClass("hide");
			}

			call_filter(spec,val,that);

		}

		function load_more(){
			
			
			$.ajax({
				url:window.filterurl ,
				data:{"filter": filters ,page: page_num},
				type:"post",
				dataType:"json",
				success:function(data){
					
					if (data.length == 0 ) {
						$("#load_more").html("No more items to load");	
						return;
					}
					window.page_num += 1;
					var templ=_.template($("#item_template").html(),{data:data});
					$("#load_more_content").replaceWith(templ);
					$("#overlay").hide(100);
				},
				error:function(){
					showNotifications("Something went wrong. Try again");
					$("#overlay").hide(100);
				}

			});

		}

		function call_filter(spec,val,that){
			
			showOverlay();

			
			$.ajax({
				url:window.filterurl ,
				data:{"filter": filters ,page : 1 },
				type:"post",
				dataType:"json",
				success:function(data){
					
					var fil_url =[];


					_.each(filters,function(val,key){
						if (typeof(val) == 'Array' && val.length > 0 ){
							fil_url .push(key + '=' + val.join(","));
						}
						else if (val.length > 0){
							fil_url .push(key + '='+ val);
						}
					});

					History.pushState('filter','filter',window.filterurl + '/'  + fil_url.join('&'));
					
					window.page_num =  2 ;

					var templ=_.template($("#item_template").html(),{data:data});
					$("#items").html(templ);
					$("#overlay").hide(100);


				},
				error:function(){
					showNotifications("Something went wrong. Try again");
					$("#overlay").hide(100);
					filters[spec].splice(filters[spec].indexOf(val),1)
					$(that).removeClass('active');
					$(that).children(".icon-remove").addClass("hide");
					
				}
			});

		}


		$(document).ready(function(){


				window.filters ={};
				window.page_num =2;
	
			 	// bind  load more

			 	$("#load_more").die().live('click',load_more);

			 	$(".spec-filter").die().live("click",function(){
					filter($(this).attr("spec-name"),$(this).attr("spec-value"),this);
			 		return false;
			 	});

				$("#filter_sort").change(function(){

					 filters['sort'] = $("#filter_sort").val();
					 call_filter('sort',$("#filter_sort").val(),$("#filter_sort"));
					 
				});


		});

		showOverlay = function(){

			$("#overlay").css({
				"width":$("#items").outerWidth(),
				"height":$("#items").outerHeight(),
				"top":$("#items").top,
				"left":$("#items").offset().left,
			});

			$("#overlay").show();

		}



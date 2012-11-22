$(document).ready ->
	sociorent.views.user_dialog = Backbone.View.extend
		tagName: "div"
		className: "user"

		template: _.template $("#user_dialog_template").html()

		events: 
			"click .menu" : "highlight_current_menu"
			"submit #profile_form" : "update_profile"
			"click #profile_orders_button" : "show_orders"
			"click #profile_wishlist_button" : "show_wishlist"
			"click #profile_update_shipping" : "update_shipping"

		initialize: ->
			_.bindAll this, 'render'

		highlight_current_menu: (ev)->
			$(".menu").removeClass "active"
			current = ev.target
			$(current).addClass "active"
			$(".menu_content").fadeOut(100).delay(100)
			content_to_activate = $(current).attr("href")
			$(content_to_activate).fadeIn(300)

		render: ->
			address = @model.get("address")
			@model.set
				address: $.parseJSON(address) || {}
			$(@el).html @template(@model.toJSON())
			this

		update_profile: ->
			profile_mobile_number = $.trim $("#profile_mobile_number").val()
			name = $.trim $("#profile_name").val()
			college = $("#profile_college").val()
			stream = $("#profile_streams").val()
			if name == ""
				$("profile_form_error").html "You can't leave your name blank."
				false
			else if !profile_mobile_number.match(/\d{10}/)
				$("profile_form_error").html "Please enter a valid mobile number."
				false
			else 
				$.ajax "/users/update" ,
					type:"post"
					async:true
					data:
						mobile_number: profile_mobile_number
						name: name
						college: college
						stream: stream
					success: (msg)->
						$("#profile_form_error").html "Your profile was updated."
				false

		show_orders: ->
			$("#orders").html ""
			if sociorent.collections.order_object.models.length == 0
				$("#orders").append "<div id='no_orders'>You have not made any orders yet.</div>"
			else
				_.each sociorent.collections.order_object.models, (model)->
					view = new sociorent.views.order
						model: model
					$("#orders").append view.render().el
				all_orders_deposit_total = _.reduce sociorent.collections.order_object.models, (sum, model)->
				 	sum + model.get("deposit_total")
				, 0
				$("#all_orders_deposit_total span").html all_orders_deposit_total
				all_orders_rental_total = _.reduce sociorent.collections.order_object.models, (sum, model)->
				 	sum + model.get("rental_total")
				, 0
				$("#all_orders_rental_total span").html all_orders_rental_total

		show_wishlist: ->
			$("#wishlist").html ""
			$.ajax "/users/wishlist" ,
				type:"post"
				async:true
				success: (msg)->
					sociorent.collections.wishlist_object.reset msg
					if sociorent.collections.wishlist_object.models.length == 0
						$("#wishlist").append "<div id='no_wishlist'>You have not made any wishlist yet.</div>"
					else
						_.each sociorent.collections.wishlist_object.models, (model)->
							view = new sociorent.views.wishlist
								model: model
							$("#wishlist").append view.render().el

		update_shipping: ->
			$.post "/update_shipping", $("#profile_shipping_form").serialize(), (resp) ->
				if resp.text is "success"
					sociorent.models.user_object.set($.parseJSON(resp.user))
					address = sociorent.models.user_object.get "address"
					sociorent.models.user_object.set
						address: $.parseJSON(address)
					alert "Shipping address updated."
					$("#shipping_form #address_street_name1").val sociorent.models.user_object.get("address").address_street_name1
					$("#shipping_form #address_street_name2").val sociorent.models.user_object.get("address").address_street_name2
					$("#shipping_form #address_city").val sociorent.models.user_object.get("address").address_city
					$("#shipping_form #address_state").val sociorent.models.user_object.get("address").address_state
					$("#shipping_form #address_pincode").val sociorent.models.user_object.get("address").address_pincode
			false
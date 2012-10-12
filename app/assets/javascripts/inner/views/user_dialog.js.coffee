$(document).ready ->
	sociorent.views.user_dialog = Backbone.View.extend
		tagName: "div"
		className: "user"

		template: _.template $("#user_dialog_template").html()

		events: 
			"click .menu" : "highlight_current_menu"
			"submit #profile_form" : "update_profile"
			"click #orders_button" : "show_orders"

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
			$(@el).html @template(@model.toJSON())
			this

		update_profile: ->
			profile_mobile_number = $.trim $("#profile_mobile_number").val()
			name = $.trim $("#profile_name").val()
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
					success: (msg)->
						$("#profile_form_error").html "Your profile was updated."
				false

		show_orders: ->
			$("#orders").html ""
			$.ajax "/users/orders" ,
				type:"post"
				async:true
				success: (msg)->
					sociorent.collections.order_object.reset msg
					_.each sociorent.collections.order_object.models, (model)->
						view = new sociorent.views.order
							model: model
						$("#orders").append view.render().el
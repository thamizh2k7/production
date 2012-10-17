sociorent.collections.compare = Backbone.Collection.extend
	model: sociorent.models.compare

	initialize: ->
		@on "add", (model)->
			$("#compare_dialog_button").show()
			if @models.length == 3
				$(".add_to_compare_box").hide()
				$("#search_to_compare").hide()
			# trigger event when something is added to compare
			sociorent.app_events.trigger "added_to_compare", model.id

		@on "remove", (model)->
			if @models.length < 3
				$(".add_to_compare_box").show()
				$("#search_to_compare").show()
			if @models.length == 0
				$("#compare_dialog_button").hide()
			sociorent.app_events.trigger "removed_from_compare", model.id
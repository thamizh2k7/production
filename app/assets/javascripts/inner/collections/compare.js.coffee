sociorent.collections.compare = Backbone.Collection.extend
	model: sociorent.models.compare

	initialize: ->
		@on "add", ()->
			$("#compare_options").show()
			if @models.length == 3
				$(".add_to_compare_box").hide()


		@on "remove", ()->
			if @models.length < 3
				$(".add_to_compare_box").show()
			if @models.length == 0
				$("#compare_options").hide()
			sociorent.fn.renderSearch()
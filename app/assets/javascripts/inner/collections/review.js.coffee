sociorent.collections.review = Backbone.Collection.extend
	model: sociorent.models.review

	initialize: ->
		@on "reset", ()->
			if @models.length == 0 
				$(".reviews_content").html "<div>No reviews are made yet.</div>"

	comparator: (model)->
		-model.id
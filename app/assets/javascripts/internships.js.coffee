$(document).ready ->
	$(".apply").click ->
		that = this
		c = confirm("Are you sure?")
		if c
			company_id = this.id.replace("company_", "")
			$.ajax "/home/apply_intership"
				type:"post"
				async:true
				data:
					company_id: company_id
				success: (msg)->
					$(that).hide().html ""
					alert("You have successfully applied for intership.")
		false
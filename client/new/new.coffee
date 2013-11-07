Template.new.events =
	"click a[name=post]": ->
		description = $('input[name=tag]').val()
		Tags.insert {description: description, date: new Date, count: 1}
		window.location.href = "/"


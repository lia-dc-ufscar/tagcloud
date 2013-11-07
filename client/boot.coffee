root = global ? window

Meteor.startup ->
	new AppRouter
	Backbone.history.start pushState: true
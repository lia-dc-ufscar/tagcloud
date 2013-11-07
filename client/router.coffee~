class window.AppRouter extends Backbone.Router
	routes:
        "cloud": "cloud"
        "new": "new"
        "*page": "index"

	new: ->  
		Session.set "current_page", "new"

	cloud: ->
		Session.set "current_page", "cloud"

	index: ->
		Session.set "current_page", "index"

Template.index.tags = ->
	Tags.find({}, {sort: {description: 1}})

Template.tag.events =
    "mousedown a": (e) ->
        id = $(e.target).attr "id"
        Tags.update(id, {$inc: {count: 1}})

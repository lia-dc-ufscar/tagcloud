
Template.cloud.tags = ->
    tags = Tags.find({}, {sort: {count: -1}})
    #tags.observe changed: makeCloud
    tags

Template.cloud.rendered = ->
    makeCloud()
    ''  

window.makeCloud = ->
    $("#awesomeCloudcloud").remove()
    $("#cloud").awesomeCloud
        options: { color: "random-light"}
        shape: "square"

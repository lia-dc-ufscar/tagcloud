fill = d3.scale.category20b()

w = 960
h = 600

Template.cloud.tags = ->
    Tags.find()

Template.cloud.rendered = ->

    
    tags = Tags.find({}, {sort: {count: -1}}).fetch().map (tag) ->
        {text: tag.description, size: tag.count}

    unless _.isEmpty tags
        cloud = d3.layout.cloud()
        cloud.timeInterval(10)
        cloud.size([w, h])
        cloud.padding(5)
        cloud.rotate ->
            ~~(Math.random() * 2) * 90 
        cloud.font("Impact")
        cloud.fontSize (d) ->
            d.size
        cloud.text (d) -> 
            d.text
        cloud.on "end", draw
        cloud.stop()
        cloud.words tags
        cloud.start()


draw = (data, bounds) ->

    d3.select("#d3cloud").selectAll("svg").remove()

    svg = d3.select("#d3cloud").append("svg")
    svg.attr("width", w)
    svg.attr("height", h)

    background = svg.append("g")
    vis = svg.append("g")
    
    vis.attr("transform", "translate(" + [w >> 1, h >> 1] + ")");

    if bounds 
        scale = Math.min(w / Math.abs(bounds[1].x - w / 2), w / Math.abs(bounds[0].x - w / 2), h / Math.abs(bounds[1].y - h / 2), h / Math.abs(bounds[0].y - h / 2)) / 2 
    else 
        scale = 1

    words = data
    words = _.sortBy words, (a, b) -> 
        b.size - a.size

    console.log "words:"
    console.log words


    text = vis.selectAll("text").data words, (d) ->
        d.text.toLowerCase()
    text.transition().duration(1000)
    text.attr "transform", (d) -> 
        "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")"
    text.style "font-size", (d) ->
        d.size + "px"
    text.enter().append("text")
        .attr("text-anchor", "middle")
        .attr "transform", (d) ->
            "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")"
        .style "font-size", (d) ->
            d.size + "px"
        .style("opacity", 1e-6)
        .transition().duration(1000)
        .style("opacity", 1)
    text
        .style "font-family", (d) ->
            d.font
        .style "fill", (d) ->
            fill(d.text.toLowerCase())
        .text (d) ->
            d.text
    exitGroup = background.append("g")
        .attr("transform", vis.attr("transform"))
    exitGroupNode = exitGroup.node()
    text.exit().each ->
        exitGroupNode.appendChild(@)
    exitGroup.transition()
        .duration(1000)
        .style("opacity", 1e-6)
        .remove()
    vis.transition()
        .delay(1000)
        .duration(750)
        .attr("transform", "translate(" + [w >> 1, h >> 1] + ")scale(" + scale + ")")

class window.CardView extends Backbone.View

  template: _.template '<span class="rank"><%= rankName %></span><span class="suit">&<%= suitName %>;</span>'

  initialize: ->
    console.log @
    @$el.attr "class", "card rank-" + @model.attributes.rankName + " " + @model.attributes.suitName
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'

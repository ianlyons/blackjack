class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '
  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()

  initialize: ->
    # set up event handler for new game
    @model.on 'newgame', (=>
      console.log 'newgame listener triggered'

      @model.on 'results', (=>
        console.log 'the winner changed'
        alert @model.get('winner') + " won!"

      )

      # @render()

      @model.get('playerHand').checkBj()
    )

    #render on initialization
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

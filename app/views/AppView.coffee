class window.AppView extends Backbone.View

  template: _.template '

  <div class="messages"></div>
    <div class="dealer-hand-container"></div>
    <div class="player-hand-container"></div>
    <div class="button-contain">
      <button class="hit-button">Hit</button>
      <button class="stand-button">Stand</button>
      <button class="newgame">New Game</button>
    </div>
  '
  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .newgame": -> @model.newgame()

  initialize: ->
    # set up event handler for new game
    @model.on 'newgame', (=>
      console.log 'newgame listener triggered'

      @render()

      @model.get('playerHand').checkBj()
    )

    @model.on 'results', (=>
      console.log 'results trigger heard'
      $('.messages').append('<span class="gameresult">' + @model.get('winner') + '</span>')
      @disableButtons()
    )

    #render on initialization
    @render(true)

  render: (first) ->
    @$el.children().detach()
    @$el.html @template()
    if !first
      @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
      @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  disableButtons: ->
    $('[class$=button]').attr('disabled', (i, oldAttr) ->
        return !oldAttr or true
      )

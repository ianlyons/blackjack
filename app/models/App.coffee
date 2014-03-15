#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    #call new game
    @newgame()

  endgame: ->
    console.log('into endgame')
    #find winner
    getBestScore = (scoreArray)->
      if scoreArray[1] and scoreArray[1] <= 21
        scoreArray[1]
      else
        scoreArray[0]

    playerScore = getBestScore @get('playerHand').scores()
    dealerScore = getBestScore @get('dealerHand').scores()
    console.log "scores: " + playerScore + ", " + dealerScore

    #set winner attribute
    @set 'winner', (if playerScore > 21
      'Player Bust! Dealer Won.'
    else if dealerScore > 21
      'Dealer Bust! Player Won.'
    else if playerScore > dealerScore and playerScore <= 21
      'Player Won!'
    else if playerScore == dealerScore
      'Push!'
    else
      'Dealer Won!')
    console.log 'results triggered'
    @trigger 'results', @
    # console.log 'the winner is: ' + @get 'winner'
    # @newgame()

  newgame: ->
    # new collections
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'winner', ''

    # new listeners
    @listenTo @get('playerHand'), 'stand', (=>
      @get('dealerHand').autoplay()
    )
    @listenTo @get('dealerHand'), 'gameover', (=>
      console.log 'dealer gameover caught by handler'
      @endgame())
    @listenTo @get('playerHand'), 'gameover', (=>
      console.log 'player gameover caught by handler'
      @endgame())

    #trigger newgame to appView
    console.log '\nnewgame called'
    @trigger 'newgame',@

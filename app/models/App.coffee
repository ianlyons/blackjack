#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'winner', ''

    @listenTo @get('playerHand'), 'stand', (=>
      @get('dealerHand').autoplay()
    )
    @listenTo @get('dealerHand'), 'gameover', @endgame

    @listenTo @get('playerHand'), 'gameover', @endgame

    @endgame = ->
      #find winner
      getBestScore = (scoreArray)->
        if scoreArray[1] and scoreArray[1] <= 21
          scoreArray[1]
        else
          scoreArray[0]

      playerScore = getBestScore @get('playerHand').scores()
      dealerScore = getBestScore @get('dealerHand').scores()
      #set winner attribute
      @set 'winner', (if playerScore > dealerScore and playerScore <= 21
        'player'
      else if playerScore == dealerScore
        'push'
      else
        'dealer')


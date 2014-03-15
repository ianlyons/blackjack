class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: -> @add(@deck.pop()).last()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce and score + 10 <= 21 then [score, score + 10] else [score]

  stand: ->
    # send trigger to app that player's turn is over
    @trigger 'stand', @

  autoplay: ->
    #auto play is called from App's handler after stand event from player

    # 1) reveal hand
    @models[0].flip()

    # 2) while score < 17, keep hitting
    if @scores.length > 1
      while @scores()[0] < 17 or @scores()[1] < 17
        @hit()
    else
      while @scores()[0] < 17
        @hit()


    # trigger to app that hand is over and score should be calculated
    debugger
    @trigger 'gameover', @




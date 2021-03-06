// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Hand = (function(_super) {
    __extends(Hand, _super);

    function Hand() {
      return Hand.__super__.constructor.apply(this, arguments);
    }

    Hand.prototype.model = Card;

    Hand.prototype.initialize = function(array, deck, isDealer) {
      this.deck = deck;
      this.isDealer = isDealer;
    };

    Hand.prototype.hit = function() {
      this.add(this.deck.pop()).last();
      if (this.scores()[0] > 21 && !this.isDealer) {
        return this.trigger('gameover', this);
      }
    };

    Hand.prototype.scores = function() {
      var hasAce, score;
      hasAce = this.reduce(function(memo, card) {
        return memo || card.get('value') === 1;
      }, false);
      score = this.reduce(function(score, card) {
        return score + (card.get('revealed') ? card.get('value') : 0);
      }, 0);
      if (hasAce && score + 10 <= 21) {
        return [score, score + 10];
      } else {
        return [score];
      }
    };

    Hand.prototype.stand = function() {
      return this.trigger('stand', this);
    };

    Hand.prototype.checkBj = function() {
      if (this.scores()[1] === 21) {
        return this.trigger('gameover', this);
      }
    };

    Hand.prototype.autoplay = function() {
      this.models[0].flip();
      if (this.scores.length > 1) {
        while (this.scores()[0] < 17 || this.scores()[1] < 17) {
          this.hit();
        }
      } else {
        while (this.scores()[0] < 17) {
          this.hit();
        }
      }
      console.log('at the end of autoplay');
      return this.trigger('gameover', this);
    };

    return Hand;

  })(Backbone.Collection);

}).call(this);

//# sourceMappingURL=Hand.map

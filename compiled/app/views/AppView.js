// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.AppView = (function(_super) {
    __extends(AppView, _super);

    function AppView() {
      return AppView.__super__.constructor.apply(this, arguments);
    }

    AppView.prototype.template = _.template('<div class="messages"></div> <div class="dealer-hand-container playingCards fourColors faceImages"></div> <div class="player-hand-container playingCards fourColors faceImages"></div> <div class="button-contain"> <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="newgame">New Game</button> </div>');

    AppView.prototype.events = {
      "click .hit-button": function() {
        return this.model.get('playerHand').hit();
      },
      "click .stand-button": function() {
        return this.model.get('playerHand').stand();
      },
      "click .newgame": function() {
        return this.model.newgame();
      }
    };

    AppView.prototype.initialize = function() {
      this.model.on('newgame', ((function(_this) {
        return function() {
          console.log('newgame listener triggered');
          _this.render();
          return _this.model.get('playerHand').checkBj();
        };
      })(this)));
      this.model.on('results', ((function(_this) {
        return function() {
          console.log('results trigger heard');
          $('.messages').append('<span class="gameresult">' + _this.model.get('winner') + '</span>');
          return _this.disableButtons();
        };
      })(this)));
      return this.render(true);
    };

    AppView.prototype.render = function(first) {
      this.$el.children().detach();
      this.$el.html(this.template());
      if (!first) {
        this.$('.player-hand-container').html(new HandView({
          collection: this.model.get('playerHand')
        }).el);
        return this.$('.dealer-hand-container').html(new HandView({
          collection: this.model.get('dealerHand')
        }).el);
      }
    };

    AppView.prototype.disableButtons = function() {
      return $('[class$=button]').attr('disabled', function(i, oldAttr) {
        return !oldAttr || true;
      });
    };

    return AppView;

  })(Backbone.View);

}).call(this);

//# sourceMappingURL=AppView.map

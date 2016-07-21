require_relative "deck"
require_relative "player"
require_relative "hand"

class Game

  attr_reader :players, :deck

  def initialize(players)
    @players = players
    @active_players = players
    @minimum_bet = 0
    @current_player = players.first
  end

  def play_hand
    @deck = Deck.new
    deck.shuffle!
  end

  def winner
  end

  def deal_hands
    players.each do | player |
      player.receive_hand(Hand.new(draw_cards(5)))
    end
  end

  def fold_player(player)
    player.fold
  end

  private

  def draw_cards(num)
    cards = []
    num.times do
      cards << deck.draw_card!
    end
    cards
  end
end

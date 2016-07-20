require_relative 'card'

class OutOfCardsError < StandardError
end

class Deck
  def self.new_deck
    deck = []
    Card::SUITS.each_key do |suit|
      (2..14).each do |value|
        deck << Card.new(value, suit)
      end
    end
    deck
  end

  attr_reader :cards
  def initialize
    @cards = Deck.new_deck
  end

  def [](index)
    @cards[index]
  end

  def shuffle!
    @cards.shuffle!
    self
  end

  def draw_card!
    raise OutOfCardsError if @cards.empty?
    @cards.shift
  end
end

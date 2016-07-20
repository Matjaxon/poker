class Card
  SUITS = {
            hearts: "H",
            diamonds: "D",
            spades: "S",
            clubs: "C"
          }

  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def <=>(other)
    value <=> other.value
  end

  def to_s
    "#{value}#{SUITS[suit]}"
  end
end

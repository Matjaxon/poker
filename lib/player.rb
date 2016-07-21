require_relative "hand"

class Player

  attr_reader :hand, :pot, :name, :bank, :folded

  def initialize(name, bank)
    @name = name
    @bank = bank
    @hand = nil
    @pot = 0
    @folded = false
  end

  def reset_player
    @pot = 0
    @folded = false
  end

  def receive_hand(hand)
    @hand = hand
  end

  def accept_winnings(winnings)
    @bank += winnings
  end

  def bet(amount)
    raise ArgumentError if amount > bank
    @bank -= amount
    @pot += amount
    amount
  end

  def discard(index)
    hand.discard(index)
  end

  def receive_card(card)
    hand.add_card(card)
  end

  def discard_prompt
    puts "Enter up to 5 cards to discard, separated by commas"
    cards_to_discard = gets.chomp.split(",").map(&:to_i).sort.reverse
    if valid_discards?(cards_to_discard)
      cards_to_discard.each { |i| discard(i) }
    else
      raise InputError
    end
  rescue InputError
    retry
  end

  def bet_prompt
    puts "Enter a bet, or enter 'f' to fold."
    input = gets.chomp
    return nil if input.downcase == "f"
    input.to_i
  end

  def show_hand
    puts hand.cards.map(&:to_s).join(" ")
  end

  def fold
    @folded = true
  end

  private

  def valid_discards?(indices)
    indices.length < 4 &&
    indices.all? { |x| x.between?(0,4) } &&
    indices.uniq == indices
  end
end

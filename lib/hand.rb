require "byebug"

class BadHandError < StandardError
end

class Hand

  HAND_RANK_NAMES = [
    "High card",
    "One pair",
    "Two pair",
    "Three of a kind",
    "Straight",
    "Flush",
    "Full house",
    "Four of a kind",
    "Straight flush"
  ]


  attr_reader :cards

  def initialize(cards)
    raise BadHandError unless cards.length == 5
    @cards = cards
  end

  def rank
    straight_flush ||
      four_of_a_kind ||
      full_house ||
      flush ||
      straight ||
      three_of_a_kind ||
      two_pair ||
      one_pair ||
      high_card
  end

  def <=>(other)
    rank <=> other.rank
  end

  private

  def straight_flush
    if flush && straight
      result = straight
      result[0] = 8
      result
    end
  end

  def four_of_a_kind
    values = cards.map(&:value)
    values.each do |value|
      return [7, [value]] if values.count(value) == 4
    end
    nil
  end

  def full_house
    nk = n_kinds
    result = nil
    if nk.values == [2,3]
      result = [6, nk.keys.reverse]
    end
    result
  end

  def flush
    suits = cards.map(&:suit)
    return [5, values.sort.reverse] if suits.all? { |suit| suit == suits.first }
    nil
  end

  def straight
    sorted_values = values.sort
    hands_to_check = [sorted_values]
    if sorted_values.any? { |value| value == 14 }
      ace_low_hand = sorted_values.dup
      ace_low_hand[4] = 1
      hands_to_check << ace_low_hand.sort
    end

    result = nil
    hands_to_check.each do |hand|
      result = [4, [hand[4]]] if (hand[0]..hand[4]).to_a == hand
    end

    result
  end

  def three_of_a_kind
    nk = n_kinds
    three_card = nk.select { | k, v | v == 3}
    return three_card.empty? ? nil : [3, three_card.keys]
  end

  def two_pair
    nk = n_kinds
    two_cards = nk.select { | k , v | v == 2}
    return two_cards.empty? ? nil : [2, two_cards.keys.sort.reverse, values]
  end

  def one_pair
    nk = n_kinds
    pair_card = nk.select { | k , v | v == 2}
    return pair_card.empty? ? nil : [1, pair_card.keys, values]
  end

  def high_card
    [0, values.sort.reverse]
  end

  def n_kinds
    result = Hash.new { 0 }
    values.each { |value| result[value] += 1 }
    result.sort_by { |k, v| v }.to_h
  end

  def values
    cards.map(&:value)
  end

end

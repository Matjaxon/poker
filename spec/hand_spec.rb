require "hand"
require "card"

describe Hand do
  let(:full_house) { Hand.new([Card.new(2, :spades), Card.new(2, :clubs),
    Card.new(2, :diamonds), Card.new(3, :spades),
    Card.new(3, :hearts)])}

  let(:four_of_a_kind) { Hand.new([Card.new(10, :spades),
    Card.new(10, :diamonds), Card.new(10, :hearts),
    Card.new(10, :clubs), Card.new(8, :spades)])}

  let(:straight_flush) { Hand.new([Card.new(14, :hearts), Card.new(13, :hearts),
    Card.new(12, :hearts), Card.new(11, :hearts),
    Card.new(10, :hearts)])}

  let(:ace_high_straight) { Hand.new([Card.new(14, :hearts), Card.new(13, :hearts),
    Card.new(12, :hearts), Card.new(11, :clubs),
    Card.new(10, :hearts)])}

  let(:high_card_hand) { Hand.new([Card.new(2, :hearts), Card.new(6, :spades),
    Card.new(10, :diamonds), Card.new(11, :clubs),
    Card.new(8, :clubs)])}

  let(:ace_low_straight) { Hand.new([Card.new(14, :hearts), Card.new(2, :hearts),
    Card.new(3, :hearts), Card.new(4, :clubs),
    Card.new(5, :hearts)])}

  describe "#initialize" do

    it "raises an error if the hand is not 5 cards" do
      expect { Hand.new([double(Card)] * 4) }.to raise_error(BadHandError)
    end

    it "assigns the cards variable" do
      cards = [Card.new(2, :spades)] * 5
      hand = Hand.new(cards)
      expect(hand.cards).to eq(cards)
    end
  end

  describe "#add_card" do
    it "adds the given card to the cards array" do
      two_of_spades = Card.new(2, :spades)
      ace_low_straight.add_card(two_of_spades)
      expect(ace_low_straight.cards).to include(two_of_spades)
      expect(ace_low_straight.cards.length).to eq(6)
    end
  end

  describe "#discard" do
    it "deletes the card at the given index" do
      ace_low_straight.discard(0)
      expect(ace_low_straight.cards.length).to eq(4)
    end
  end

  describe "#rank" do
    it "returns the strongest hand" do
      expect(full_house.rank).to eq([6, [2, 3]])
      expect(straight_flush.rank).to eq([8, [14]])
      expect(high_card_hand.rank).to eq([0, [11, 10, 8, 6, 2]])
      expect(four_of_a_kind.rank).to eq([7,[10]])
      expect(ace_high_straight.rank).to eq([4, [14]])
      expect(ace_low_straight.rank).to eq([4, [5]])
    end

  end

  describe "#<=>" do
    let (:hand1) { Hand.new([
      Card.new(14, :spades),
      Card.new(14, :clubs),
      Card.new(6, :spades),
      Card.new(10, :hearts),
      Card.new(7, :diamonds)
      ]) }

    let(:hand2) { Hand.new([
      Card.new(13, :spades),
      Card.new(13, :clubs),
      Card.new(6, :spades),
      Card.new(10, :hearts),
      Card.new(7, :diamonds)
      ]) }

    let(:hand3) { Hand.new([
      Card.new(13, :spades),
      Card.new(13, :clubs),
      Card.new(6, :spades),
      Card.new(11, :hearts),
      Card.new(7, :diamonds)
      ])}

    it "returns 1 if the first hand is stronger" do
      expect(straight_flush <=> four_of_a_kind).to eq(1)
    end
    it "returns -1 if the second hand is stronger" do
      expect(high_card_hand <=> four_of_a_kind).to eq(-1)
    end
    it "returns 0 if both hands are equally strong" do
      expect(full_house <=> full_house).to eq(0)
    end
    it "correctly compares hands of different ranks" do
      expect(full_house <=> four_of_a_kind).to eq(-1)
    end
    it "relies on the high cards if hands are equal rank" do
      expect(hand1 <=> hand2).to eq(1)
    end
    it "uses the next highest card if the hands' high cards are equal" do
      expect(hand2 <=> hand3).to eq(-1)
    end
    it "knows that an ace-high straight beats an ace-low straight" do
      expect(ace_high_straight <=> ace_low_straight).to eq(1)
    end

  end

end

require "deck"

describe Deck do

  subject(:deck) { Deck.new }

  describe "#initialize" do
    it "starts with a standard deck of cards" do
      expect(deck.cards.size).to eq(52)
      expect(deck[0]).to be_a(Card)
      num_spades = deck.cards.count { |card| card.suit == :spades }
      expect(num_spades).to eq(13)
    end

  end

  describe "#shuffle!" do
    it "shuffles the deck" do
      old_first_card = deck.cards[0]
      new_first_card = deck.shuffle![0]
      expect(old_first_card).to_not eq(new_first_card)
    end
  end

  describe "#draw_card!" do
    it "returns a card from the top of the deck" do
      first_card = deck[0]
      expect(deck.draw_card!).to be(first_card)
    end

    it "modifies the deck" do
      first_card = deck[0]
      deck.draw_card!
      expect(deck[0]).to_not eq(first_card)
      expect(deck.cards.length).to eq(51)
    end

    it "fails if the deck is empty" do
      52.times { deck.draw_card! }
      expect { deck.draw_card! }.to raise_error(OutOfCardsError)
    end

  end

end

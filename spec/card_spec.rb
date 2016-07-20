require "card"

describe "Card" do
  subject(:card) { Card.new(6, :spades) }

  describe "#initialize" do

    it "generates a card with a value" do
      expect(card.value).to eq(6)
    end

    it "generates a card with a suit" do
      expect(card.suit).to be(:spades)
    end
  end

  describe "#<=>" do
    let(:card1) { card }
    let(:card2) { Card.new(4, :hearts) }
    let(:card3) { Card.new(4, :spades) }
    it "returns 1 if first card is higher" do
      expect(card1 <=> card2).to eq(1)
    end

    it "returns 0 if cards have same value" do
      expect(card2 <=> card3).to eq(0)
    end

    it "returns -1 if second card is higher" do
      expect(card2 <=> card1).to eq(-1)
    end

  end

  describe "#to_s" do
    it "returns the value and suit of a card" do
      expect(card.to_s).to eq("6S")
    end
  end
end

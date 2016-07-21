require "player"
require "hand"
require "card"
require "byebug"

describe Player do
  subject(:player) { Player.new("Bill", 1_000)}
  let(:hand) { Hand.new([Card.new(14, :hearts),
    Card.new(13, :hearts),
    Card.new(12, :hearts),
    Card.new(11, :clubs),
    Card.new(10, :hearts)])}

  describe "#initialize" do

    it "sets the players name" do
      expect(player.name).to eq("Bill")
    end

    it "sets a default amount of money to the players pot" do
      expect(player.bank).to eq(1_000)
    end
  end

  describe "#receive_hand" do
    it "receives a new hand" do
      player.receive_hand(hand)
      expect(player.hand).to be(hand)
    end
  end

  describe "#pot" do
    it "returns the value that the player has bet" do
      expect(player.pot).to eq(0)
    end
  end

  describe "#bet" do

    before(:each) { player.bet(100) }

    it "increases the player's pot" do
      expect(player.pot).to eq(100)
    end
    it "decreases the player's bank" do
      expect(player.bank).to eq(900)
    end
    it "returns the value that the player bet" do
      expect(player.bet(100)).to eq(100)
    end
    it "raises an error if the player bets more than their bank" do
      expect { player.bet(2983756902837) }.to raise_error(ArgumentError)
    end

  end

  describe "#reset_pot" do
    it "can be reset to 0 at the start of a new hand" do
      player.bet(50)
      player.reset_pot
      expect(player.pot).to eq(0)
    end
  end


  describe "#accept_winnings" do
    it "increases the players bank" do
      player.accept_winnings(500)
      expect(player.bank).to eq(1_500)
    end
  end


  describe "#discard" do
    it "removes a card from the player's hand" do
      player.receive_hand(hand)
      #expect(player.hand).to receive(:discard).with(3)
      player.discard(3)
      expect(player.hand.cards.length).to eq(4)
    end

  end

  describe "#receive_card" do
    it "adds new card to the player's hand" do
      dummy_card = double(Card)
      player.receive_hand(hand)
      player.receive_card(dummy_card)
      expect(player.hand.cards.length).to eq(6)
    end
  end


end

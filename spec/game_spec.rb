require "game"
require "rspec"
require "deck"


describe Game do

  let(:player1) { Player.new("Glen", 1_000) }
  let(:player2) { Player.new("Maggie", 1_000) }

  subject(:game) { Game.new([player1, player2]) }

  describe "#initialize" do
    it "sets players upon initialization" do
      expect(game.players).to eq([player1, player2])
    end
  end

  describe "#play_hand" do
    it "generates a new deck" do
      game.play_hand
      expect(game.deck).to be_a(Deck)
    end
  end

  describe "#winner" do
    it "determines the winner"
    it "awards winnings"
  end

  describe "#deal_hands" do
    it "generates a new hand for each player" do
      game.play_hand
      game.deal_hands
      expect(player1.hand).to be_a(Hand)
      expect(player1.hand.cards.length).to eq(5)
      expect(player2.hand).to be_a(Hand)
      expect(player2.hand.cards.length).to eq(5)
    end
    it "draws cards from the deck" do
      game.play_hand
      game.deal_hands
      expect(game.deck.cards.length).to eq(42)
    end
  end

  describe "#place_bets" do
    it "collects player bets"
    it "increases the pot"
  end

  describe "#deal_card" do
    it "passes the new card to the player"
  end

  describe "#fold_player" do
    it "changes the player's status to folded" do
      game.fold_player(player1)
      expect(player1.folded).to be true
    end
  end

  describe "#valid_bet?" do
  end
end

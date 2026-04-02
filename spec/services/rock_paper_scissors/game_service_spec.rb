require "rails_helper"

RSpec.describe RockPaperScissors::GameService do
  subject(:game) { described_class.call(player_throw: "rock") }

  describe ".call" do
    context "when the API client succeeds" do
      before do
        allow(RockPaperScissors::Client).to receive(:call).and_return(success: true, throw: "scissors")
      end

      it "returns a Game instance" do
        expect(game).to be_a(Game)
      end

      it "sets the player throw" do
        expect(game.player_throw).to eq("rock")
      end

      it "uses the server throw from the API" do
        expect(game.server_throw).to eq("scissors")
      end
    end

    context "when the API client fails" do
      before do
        allow(RockPaperScissors::Client).to receive(:call).and_return(success: false)
      end

      it "returns a Game instance" do
        expect(game).to be_a(Game)
      end

      it "falls back to a valid throw" do
        expect(Game::VALID_THROWS).to include(game.server_throw)
      end
    end

    it "calls the API client exactly once" do
      allow(RockPaperScissors::Client).to receive(:call).and_return(success: true, throw: "rock")
      game
      expect(RockPaperScissors::Client).to have_received(:call).once
    end
  end
end

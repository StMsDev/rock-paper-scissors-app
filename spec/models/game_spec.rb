require "rails_helper"

RSpec.describe Game do
  subject(:game) { described_class.new(player_throw: player_throw, server_throw: server_throw) }

  describe "#result" do
    context "when the player wins" do
      winning_matchups = { "rock" => "scissors", "paper" => "rock", "scissors" => "paper" }

      winning_matchups.each do |player, server|
        context "with #{player} vs #{server}" do
          let(:player_throw) { player }
          let(:server_throw) { server }

          it { expect(game.result).to eq(:win) }
        end
      end
    end

    context "when the player loses" do
      losing_matchups = { "rock" => "paper", "paper" => "scissors", "scissors" => "rock" }

      losing_matchups.each do |player, server|
        context "with #{player} vs #{server}" do
          let(:player_throw) { player }
          let(:server_throw) { server }

          it { expect(game.result).to eq(:lose) }
        end
      end
    end

    context "when it is a tie" do
      Game::VALID_THROWS.each do |throw_name|
        context "with #{throw_name} vs #{throw_name}" do
          let(:player_throw) { throw_name }
          let(:server_throw) { throw_name }

          it { expect(game.result).to eq(:tie) }
        end
      end
    end
  end

  describe "constants" do
    it "defines exactly three valid throws" do
      expect(Game::VALID_THROWS).to match_array(%w[rock paper scissors])
    end

    it "maps each throw to what it beats" do
      expect(Game::THROWS).to eq(
        "rock" => %w[scissors],
        "paper" => %w[rock],
        "scissors" => %w[paper]
      )
    end
  end

  describe "attributes" do
    let(:player_throw) { "rock" }
    let(:server_throw) { "scissors" }

    it "exposes player_throw" do
      expect(game.player_throw).to eq("rock")
    end

    it "exposes server_throw" do
      expect(game.server_throw).to eq("scissors")
    end
  end
end

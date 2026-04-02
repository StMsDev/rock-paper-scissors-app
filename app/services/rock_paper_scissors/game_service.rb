class RockPaperScissors::GameService
  attr_reader :player_throw

  def self.call(player_throw:)
    new(player_throw: player_throw).call
  end

  def initialize(player_throw:)
    @player_throw = player_throw
  end

  def call
    server_throw = fetch_server_throw
    Game.new(player_throw: player_throw, server_throw: server_throw)
  end

  private

  def fetch_server_throw
    result = RockPaperScissors::Client.call
    result[:success] ? result[:throw] : random_throw
  end

  def random_throw
    Game::VALID_THROWS.sample
  end
end

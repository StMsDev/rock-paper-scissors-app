class Game
  THROWS = {
    "rock"     => %w[scissors],
    "paper"    => %w[rock],
    "scissors" => %w[paper]
  }.freeze

  VALID_THROWS = THROWS.keys.freeze

  attr_reader :player_throw, :server_throw

  def initialize(player_throw:, server_throw:)
    @player_throw = player_throw
    @server_throw = server_throw
  end

  def result
    return :tie if player_throw == server_throw
    return :win if THROWS[player_throw].include?(server_throw)

    :lose
  end
end

class GamesController < ApplicationController
  before_action :validate_throw, only: :play

  def new; end

  def play
    game = RockPaperScissors::GameService.call(player_throw: params[:throw])

    render json: {
      player_throw: game.player_throw,
      server_throw: game.server_throw,
      result: game.result
    }
  end

  private

  def validate_throw
    return if Game::VALID_THROWS.include?(params[:throw])

    render json: { error: "Invalid throw" }, status: :unprocessable_entity
  end
end

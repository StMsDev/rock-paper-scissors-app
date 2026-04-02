module GamesHelper
  def game_throw_icons_json
    Game::VALID_THROWS.each_with_object({}) do |throw_name, icons|
      icons[throw_name] = image_path("#{throw_name}.svg")
    end.to_json
  end

  def game_i18n_json
    {
      results: {
        win: t("rps_game.javascript.results.win"),
        lose: t("rps_game.javascript.results.lose"),
        tie: t("rps_game.javascript.results.tie")
      },
      result_verbs: {
        win: t("rps_game.javascript.result_verbs.win"),
        lose: t("rps_game.javascript.result_verbs.lose"),
        tie: t("rps_game.javascript.result_verbs.tie")
      },
      errors: {
        general: t("rps_game.javascript.errors.general")
      }
    }.to_json
  end
end

require "rails_helper"

RSpec.describe GamesHelper, type: :helper do
  describe "#game_throw_icons_json" do
    it "returns valid JSON with a key for each throw" do
      parsed = JSON.parse(helper.game_throw_icons_json)
      expect(parsed.keys).to match_array(Game::VALID_THROWS)
    end
  end

  describe "#game_i18n_json" do
    it "returns valid JSON with the expected translation keys" do
      parsed = JSON.parse(helper.game_i18n_json)

      expect(parsed["results"].keys).to match_array(%w[win lose tie])
      expect(parsed["result_verbs"].keys).to match_array(%w[win lose tie])
      expect(parsed["errors"]).to have_key("general")
    end
  end
end

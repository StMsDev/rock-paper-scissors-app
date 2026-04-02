require "rails_helper"

RSpec.describe "Games", type: :request do
  describe "GET /" do
    it "returns 200 and renders the game page" do
      get root_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("game-data")
    end
  end

  describe "POST /play" do
    before do
      allow(RockPaperScissors::Client).to receive(:call).and_return(success: true, throw: "scissors")
    end

    context "with a valid throw" do
      it "returns 200 with the game result JSON" do
        post play_path, params: { throw: "rock" }, as: :json

        expect(response).to have_http_status(:ok)

        body = response.parsed_body
        expect(body).to include(
          "player_throw" => "rock",
          "server_throw" => "scissors",
          "result" => "win"
        )
      end
    end

    context "with an invalid throw" do
      it "returns 422 with an error message" do
        post play_path, params: { throw: "lizard" }, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body).to eq("error" => "Invalid throw")
      end
    end

    context "with a missing throw param" do
      it "returns 422 with an error message" do
        post play_path, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body).to eq("error" => "Invalid throw")
      end
    end
  end
end

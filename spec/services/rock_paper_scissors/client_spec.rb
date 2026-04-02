require "rails_helper"

RSpec.describe RockPaperScissors::Client do
  subject(:result) { described_class.call }

  let(:api_url) { RockPaperScissors::Client::API_URL }

  describe ".call" do
    context "when the API returns 200 with a valid throw" do
      before do
        stub_request(:get, api_url).to_return(
          status: 200,
          body: { statusCode: 200, body: "Rock" }.to_json
        )
      end

      it "returns success with the downcased throw" do
        expect(result).to eq(success: true, throw: "rock")
      end
    end

    context "when the API returns a 500 server error" do
      before do
        stub_request(:get, api_url).to_return(
          status: 500,
          body: { statusCode: 500, body: "Something went wrong." }.to_json
        )
      end

      it "returns a non-success result" do
        expect(result[:success]).to be false
      end
    end

    context "when the request times out (Net::ReadTimeout)" do
      before do
        stub_request(:get, api_url).to_timeout
      end

      it "returns failure" do
        expect(result).to eq(success: false)
      end

      it "logs the error" do
        allow(Rails.logger).to receive(:error)
        result
        expect(Rails.logger).to have_received(:error).with(/Request failed/)
      end
    end

    context "when the response body is invalid JSON" do
      before do
        stub_request(:get, api_url).to_return(
          status: 200,
          body: "not json"
        )
      end

      it "returns failure" do
        expect(result).to eq(success: false)
      end
    end

    context "when a network error occurs" do
      before do
        stub_request(:get, api_url).to_raise(SocketError.new("getaddrinfo: Name or service not known"))
      end

      it "returns failure" do
        expect(result).to eq(success: false)
      end

      it "logs the error" do
        allow(Rails.logger).to receive(:error)
        result
        expect(Rails.logger).to have_received(:error).with(/Request failed.*Name or service not known/)
      end
    end
  end
end

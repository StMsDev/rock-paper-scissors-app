require "net/http"
require "json"

class RockPaperScissors::Client
  API_URL = "https://private-anon-f7bda37be3-curbrockpaperscissors.apiary-mock.com/rps-stage/throw".freeze
  TIMEOUT = 5

  def self.call
    new.call
  end

  def call
    uri = URI(API_URL)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true, open_timeout: TIMEOUT, read_timeout: TIMEOUT) do |http|
      http.get(uri.request_uri)
    end

    parse_response(response)
  rescue StandardError => e
    Rails.logger.error("[RpsApiClient] Request failed: #{e.message}")
    { success: false }
  end

  private

  def parse_response(response)
    body = JSON.parse(response.body)
    throw_value = body["body"]&.downcase

    { success: response.is_a?(Net::HTTPSuccess), throw: throw_value }
  end
end

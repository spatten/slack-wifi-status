require 'net/http'
require 'uri'
require 'cgi'
require 'json'

module SlackWifiStatus
  # Set the emoji and status text on Slack
  class UpdateStatus
    def self.post(message: '', emoji: '')
      uri = URI.parse('https://slack.com/api/users.profile.set')

      payload = { status_text: message, status_emoji: emoji }.to_json
      token = ENV['SLACK_WIFI_STATUS_KEY']

      uri.query = URI.encode_www_form(token: token, profile: payload)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)

      response = http.request(request)
      puts "response: #{response}"
      response
    end
  end
end

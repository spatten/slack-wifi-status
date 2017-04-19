require 'net/http'
require 'uri'
require 'json'

module SlackWifiStatus
  # Set the emoji and status text on Slack
  class UpdateStatus
    def self.post(message: '', emoji: '')
      uri = URI.parse('https://slack.com/api/users.profile.set')

      payload = { status_text: message, status_emoji: emoji }.to_json
      token = SlackWifiStatus::Config.config['oauth_key']

      uri.query = URI.encode_www_form(token: token, profile: payload)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)

      response = http.request(request)
      response
    end
  end
end

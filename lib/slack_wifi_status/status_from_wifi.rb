module SlackWifiStatus
  class StatusFromWifi
    def self.ssid
      @ssid ||= `/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}'`.chomp
    end

    def self.home_ssid?
      home_ssids.include?(ssid)
    end

    def self.home_ssids
      SlackWifiStatus::Config.config['home_ssids']
    end

    def self.status_hash
      if home_ssid?
        { message: 'At Home', emoji: ':house_with_garden:' }
      else
        { message: 'At a coffee shop', emoji: ':coffee:' }
      end
    end

    def self.set_status
      SlackWifiStatus::UpdateStatus.post(status_hash)
    end
  end
end

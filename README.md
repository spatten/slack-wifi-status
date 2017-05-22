# Slack Wifi Status

Set your Slack status to either :house_with_garden: or :coffee: based on your wifi SSID.

You list a set of SSIDs that count as being at home. If you're at home, then your status is set to

> :house_with_garden: At Home

If you are using an SSID not on the list, then your status is set to

> :coffee: At a coffee shop

## Setup

To setup, you'll need an OAUTH key for Slack and a list of SSIDs that count as being at home ([kinda detailed OAuth setup instructions](#detailed-oauth-instructions)).

clone the repo:

```
git clone https://github.com/spatten/slack-wifi-status.git
```
Install the required gems:

```
cd slack-wifi-status
bundle install
```

Create a file in `config/slack.yml` that looks like this:

```yaml
---
oauth_key: "xoxp-this-is-a-totally-real-oauth-key"
home_ssids:
  - Pretty Fly for a Wi-Fi
  - FBI Surveillance Van 119871
  - TellMyWiFiLoveHer
```

You can test your setup by running

```
./bin/update-slack-status
```

It should update your status on Slack.

## Automatically updating your status

Setup a cron job that runs every five minutes and runs `bin/update-slack-status`, like this:

```
*/5 * * * * cd /Users/yourname/path/to/code/slack-wifi-status && ./bin/update-slack-status > /dev/null 2> /dev/null
```

## Detailed OAuth instructions

Go to https://api.slack.com/apps

Create a new app for the organization you're going to be changing your status on.

You need to set the permissions needed. You need `users.profile:read` and `users.profile:write`.

Slack will then give you an OAuth access token. Copy it and stick it in `config/slack.yml`.


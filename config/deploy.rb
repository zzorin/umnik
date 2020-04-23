require 'openteam/capistrano/deploy'

# append :linked_dirs, 'data'

append :rvm_map_bins, 'rails'

set :slackistrano,
  channel: (Settings['slack.channel'] rescue ''),
  webhook: (Settings['slack.webhook'] rescue '')

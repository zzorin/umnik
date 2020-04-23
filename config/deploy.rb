require 'openteam/capistrano/deploy'

# append :linked_dirs, 'data'

append :rvm_map_bins, 'rails'

namespace :deploy do
  desc 'Webpacker compile'
  task 'webpacker:compile' do
    sh 'RAILS_ENV=production bundle exec rails webpacker:clobber'
    sh 'RAILS_ENV=production bundle exec rails webpacker:compile'

    on roles(:app) do
      upload! 'public/packs', "#{release_path}/public", recursive: true
    end

    sh 'rm -rf public/packs'
  end
end

after 'deploy:assets:precompile', 'deploy:webpacker:compile'

set :slackistrano,
  channel: (Settings['slack.channel'] rescue ''),
  webhook: (Settings['slack.webhook'] rescue '')

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Umnik
  class Application < Rails::Application
    config.load_defaults 6.0

    config.i18n.default_locale = :ru
    config.i18n.available_locales = [:ru, :en]

    config.active_record.belongs_to_required_by_default = false
    config.time_zone = 'Krasnoyarsk'

    config.eager_load_paths << Rails.root.join('lib')

    Rails.application.config.active_record.belongs_to_required_by_default = false

    config.generators do |g|
      g.test_framework :rspec,
        view_specs: false,
        helper_specs: false,
        routing_specs: false
    end
  end
end

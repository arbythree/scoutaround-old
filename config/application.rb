require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Scoutaround
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.action_dispatch.rescue_responses["Pundit::NotAuthorizedError"] = :forbidden
    config.autoload_paths += %W(#{config.root}/app/notifiers)
  end
end

Raven.configure do |config|
  config.dsn = 'https://017f247a702546bba3150a6072ebf085:61e00175c94d464393a88604c3ca2ed3@sentry.io/1228379'
end

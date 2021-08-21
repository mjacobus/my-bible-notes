require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module BibleTools
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.middleware.use OmniAuth::Builder do
      if ENV['OAUTH_GOOGLE_KEY']
        provider :google_oauth2, ENV['OAUTH_GOOGLE_KEY'], ENV['OAUTH_GOOGLE_SECRET']
      end
    end

    config.i18n.available_locales = ["pt-BR"]
    config.i18n.default_locale = 'pt-BR'
    config.time_zone = 'America/Sao_Paulo'

    config.generators do |generate|
      generate.helper false
      generate.assets false
      generate.view_specs false
    end

    config.autoload_paths << "#{Rails.root}/lib"
  end
end

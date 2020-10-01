require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Share
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # エラーメッセージの日本語化
    config.i18n.default_locale = :ja

    # 日本時間に設定
    config.time_zone = 'Tokyo'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    # Rspec導入
    config.generators do |g|
        g.test_framework :rspec,
        fixtures: false,
        view_specs: false,
        helper_specs: false,
        routing_specs: false
    end
  end
end

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SaleshopOnline
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.time_zone = 'Moscow'
    config.i18n.default_locale = :ru
    # config.active_job.queue_adapter = :sidekiq

    # почта
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.smtp_settings = {
      enable_starttls_auto:   true,
      address:                'smtp.yandex.ru',
      port:                   587,
      domain:                 'saleshop.online',
      authentication:         'plain',
      user_name:              'robot@saleshop.online',
      password:               'w26a7sEa'
    }

  end
end

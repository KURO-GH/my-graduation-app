# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable serving static files from the `/public` folder by default.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Logging
  config.log_level = :info
  config.log_tags  = [:request_id]

  # Action Mailer (Devise用URL設定)
  config.action_mailer.default_url_options = {
    host: 'my-graduation-app.onrender.com',
    protocol: 'https'
  }

  # SMTP 設定
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.smtp_settings = {
    address:              ENV['SMTP_ADDRESS'],   # 例: "smtp.gmail.com"
    port:                 587,
    domain:               ENV['SMTP_DOMAIN'],    # 例: "mydomain.com"
    user_name:            ENV['SMTP_USERNAME'],
    password:             ENV['SMTP_PASSWORD'],
    authentication:       :plain,
    enable_starttls_auto: true
  }

  config.action_mailer.perform_caching = false

  # I18n
  config.i18n.fallbacks = true

  # Deprecation notices
  config.active_support.report_deprecations = false

  # Logging formatter
  config.log_formatter = Logger::Formatter.new
  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # その他、必要に応じて force_ssl やキャッシュストアなどを追加
  # config.force_ssl = true
  # config.cache_store = :mem_cache_store
end

# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  # ================================
  # 基本設定
  # ================================

  config.cache_classes = true
  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.compile = false

  config.active_storage.service = :local

  config.log_level = :info
  config.log_tags  = [:request_id]

  # ================================
  # Action Mailer（SendGrid API方式）
  # ================================

  config.action_mailer.default_url_options = {
    host: 'my-graduation-app-1.onrender.com',
    protocol: 'https'
  }

  config.action_mailer.default_options = {
    from: 'k.s06020608@gmail.com'
  }

  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false

  config.action_mailer.delivery_method = :sendgrid_actionmailer

  config.action_mailer.sendgrid_actionmailer_settings = {
    api_key: ENV['SENDGRID_API_KEY'],
    raise_delivery_errors: true
  }

  # ================================
  # ActiveJob
  # ================================
  config.active_job.queue_adapter = :async

  # ================================
  # その他
  # ================================

  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false

  config.log_formatter = Logger::Formatter.new
  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false
end

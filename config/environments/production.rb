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
  # Action Mailer（Devise / SendGrid）
  # ================================

  # URL 設定（Devise のリンク用）
  config.action_mailer.default_url_options = {
    host: 'my-graduation-app.onrender.com',
    protocol: 'https'
  }

  # From アドレス（SendGridで検証済み）
  config.action_mailer.default_options = {
    from: 'k.s06020608@gmail.com'
  }

  # SMTP 設定（SendGrid）
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.smtp_settings = {
    address: 'smtp.sendgrid.net',
    port: 587,
    user_name: 'apikey',
    password: ENV['SMTP_PASSWORD'],
    authentication: :plain,
    enable_starttls_auto: true,
    open_timeout: 5,
    read_timeout: 5
  }

  # ================================
  # ActiveJob（本番でメールを確実に送る）
  # ================================
  config.active_job.queue_adapter = :async

  config.action_mailer.perform_caching = false

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

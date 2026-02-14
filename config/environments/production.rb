require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance and memory savings (ignored by Rake tasks).
  config.eager_load = true

  # Full error reports are disabled.
  config.consider_all_requests_local = false

  # Turn on fragment caching in view templates.
  config.action_controller.perform_caching = true

  # Cache assets for far-future expiry since they are all digest stamped.
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Log to STDOUT with the current request id as a default log tag.
  config.log_tags = [ :request_id ]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)

  # Log level
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Prevent health checks from clogging up the logs.
  config.silence_healthcheck_path = "/up"

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Cache / Job
  config.cache_store = :solid_cache_store
  config.active_job.queue_adapter = :solid_queue
  config.solid_queue.connects_to = { database: { writing: :queue } }

  # ================== Action Mailer（Resend） ==================

  # メール送信エラーを表示（本番では必須）
  config.action_mailer.raise_delivery_errors = true

  # Resend を使う
  config.action_mailer.delivery_method = :resend

  # メール内リンク用 URL（Devise）
  config.action_mailer.default_url_options = {
    host: "futari-log.onrender.com",
    protocol: "https"
  }

  # ============================================================

  # I18n
  config.i18n.fallbacks = true

  # Active Record
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [ :id ]

  # Host Authorization
  # config.hosts = [
  #   "example.com",
  #   /.*\.example\.com/
  # ]
  # config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end

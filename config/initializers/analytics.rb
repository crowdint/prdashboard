config = Prdashboard::Application.config
config.analytics_id = Rails.env.production? ? ENV['ANALYTICS_ID'] : nil
config.analytics_domain = Rails.env.production? ? ENV['ANALYTICS_DOMAIN'] : nil

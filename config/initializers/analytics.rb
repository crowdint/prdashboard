Prdashboard::Application.config.analytics_id = Rails.env.production? ? ENV['ANALYTICS_ID'] : nil
Prdashboard::Application.config.analytics_domain = Rails.env.production? ? ENV['ANALYTICS_DOMAIN'] : nil


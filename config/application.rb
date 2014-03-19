require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'dotenv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

Dotenv.load

module Prdashboard
  class Application < Rails::Application
    config.assets.precompile += %w(
                                    ember_application.js,
                                    analytics/analytics.js
                                  )
  end
end

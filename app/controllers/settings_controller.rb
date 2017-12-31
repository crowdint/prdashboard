class SettingsController < ApplicationController
  ANALYTICS_KEYS = {
    id: Prdashboard::Application.config.analytics_id,
    domain: Prdashboard::Application.config.analytics_domain
  }

  def analytics_keys
    render json: ANALYTICS_KEYS, status: :ok
  end
end

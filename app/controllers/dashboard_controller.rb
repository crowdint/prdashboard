class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @pull_requests = get_pull_requests

    render 'dashboard/index'
  end

  private

  def get_pull_requests
    GithubService.new(session[:user_token]).get_pull_requests organization
  end

  def organization
    params[:organization] || 'crowdint'
  end

end


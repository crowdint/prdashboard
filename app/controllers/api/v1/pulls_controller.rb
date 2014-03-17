class Api::V1::PullsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @pull_requests = get_pull_requests
    @repositories  = @pull_requests.map(&:repository).uniq { |e| [e.id] }
    @users         = @pull_requests.map(&:user).uniq { |e| [e.id] }

    render 'api/v1/pulls/index'
  end

  def update
    GithubService.new(session[:user_token]).merge_pull_request merge_params, current_user
    Rails.cache.clear

    render json: { status: :ok }
  end

  private

  def merge_params
    params.permit(:id, :repo)
  end

  def get_pull_requests
    GithubService.new(session[:user_token]).get_pull_requests organization
  end

  def organization
    params[:organization] || 'crowdint'
  end

end


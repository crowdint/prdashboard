module Api
  module V1
    class PullsController < Api::V1::ApplicationController
      before_action :authenticate_user!

      def index
        @pull_requests, @repositories, @users = pull_requests
        render 'api/v1/pulls/index'
      end

      def update
        action = "#{action_param}_pull_request".to_sym
        GithubService.new(session[:user_token]).send(action, pull_params, current_user)

        Rails.cache.clear

        render json: { status: :ok }
      end

      def mergeable
        render json: { mergeable: GithubService.new(session[:user_token]).pull_mergeable?(pull_params) }
      end

      private

      def action_param
        params[:kind]
      end

      def pull_params
        params.permit(:id, :repo)
      end

      def pull_requests
        GithubService.new(session[:user_token]).pull_requests organization
      end

      def organization
        params[:organization] || 'crowdint'
      end

    end
  end
end


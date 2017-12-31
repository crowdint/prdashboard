module Api
  module V1
    class OrganizationsController < Api::V1::ApplicationController
      before_action :authenticate_user!

      def index
        @organizations = organizations

        render 'api/v1/organizations/index'
      end

      private

      def organizations
        GithubService.new(session[:user_token]).organizations
      end
    end
  end
end

module Api
  module V1
    class OrganizationsController < Api::V1::ApplicationController
      before_filter :authenticate_user!

      def index
        @organizations = get_organizations

        render 'api/v1/organizations/index'
      end

      private

      def get_organizations
        GithubService.new(session[:user_token]).get_organizations
      end

    end
  end
end


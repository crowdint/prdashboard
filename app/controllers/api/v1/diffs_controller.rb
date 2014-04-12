module Api
  module V1
    class DiffsController < Api::V1::ApplicationController
      before_action :authenticate_user!

      def show
        render text: GithubService.new(session[:user_token]).diff(diff_params)
      end

      private

      def diff_params
        params.permit(:id, :repo)
      end

    end
  end
end


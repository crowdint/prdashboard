module Api
  module V1
    class CommentsController < Api::V1::ApplicationController
      before_action :authenticate_user!

      def index
        @comments = GithubService.new(session[:user_token]).pull_comments(comment_params)

        render 'api/v1/comments/index'
      end

      def create
        GithubService.new(session[:user_token]).create_pull_comment(comment_params)

        render json: { status: 'ok' }
      end

      private

      def comment_params
        params.permit(:repo, :pull, :text)
      end
    end
  end
end

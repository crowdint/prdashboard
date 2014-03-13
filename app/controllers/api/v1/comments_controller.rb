class Api::V1::CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    GithubService.new(session[:user_token]).create_pull_comment(comment_params)

    render json: { status: 'ok' }
  end

  private

  def comment_params
    params.permit(:repo, :pull, :text)
  end

end


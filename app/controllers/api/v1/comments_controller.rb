class Api::V1::CommentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @comments = GithubService.new(session[:user_token]).get_pull_comments(comment_params)

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


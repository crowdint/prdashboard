class Api::V1::DiffsController < Api::V1::ApplicationController
  before_filter :authenticate_user!

  def show
    render text: GithubService.new(session[:user_token]).get_diff(diff_params)
  end

  private

  def diff_params
    params.permit(:id, :repo)
  end

end


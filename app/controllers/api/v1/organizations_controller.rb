class Api::V1::OrganizationsController < ApplicationController
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


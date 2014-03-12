class DashboardController < ApplicationController
  layout 'dashboard'
  before_filter :authenticate_user!

  def index; end

end


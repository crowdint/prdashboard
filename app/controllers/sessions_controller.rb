class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    session[:user_id] = find_user(auth).id
    session[:user_token] = auth['credentials']['token']

    redirect_to dashboard_url, notice: 'Signed in!'
  end

  def destroy
    session[:user_id] = nil
    session[:user_token] = nil
    redirect_to root_url, notice: 'Signed out!'
  end

  protected

  def find_user(auth)
    User.find_by_provider_and_uid(auth['provider'], auth['uid']) || User.create_with_omniauth(auth)
  end
end

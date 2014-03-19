require 'spec_helper'

describe SessionsController do
  describe '#create' do
    before do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
      post :create
    end

    it 'redirects to dashboard' do
      expect(subject).to redirect_to dashboard_path
    end

    it 'should set session data' do
      expect(session[:user_id]).to eql User.last.id
    end
  end

  describe '#destroy' do
    before do
      signin_user
      delete :destroy
    end

    it 'destroy session data' do
      expect(session[:user_id]).to be_nil
      expect(session[:user_token]).to be_nil
    end

    it 'redirects to root path' do
      expect(subject).to redirect_to root_path
    end
  end
end


require 'spec_helper'

describe WelcomeController do
  describe '#index' do
    context 'when user is not logged in' do
      it 'should response 200' do
        get :index
        expect(response.status).to eql 200
      end
    end

    context 'when user is logged in' do
      before { signin_user }

      it 'should redirect to dashboard page' do
        get :index
        expect(subject).to redirect_to dashboard_path
      end
    end
  end
end


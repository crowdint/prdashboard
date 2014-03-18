require 'spec_helper'

describe WelcomeController do
  describe '#index' do

    it 'should render index' do
      get :index
      expect(response.status).to eql 200
    end
  end
end

